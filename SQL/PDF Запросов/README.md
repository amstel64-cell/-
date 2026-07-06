**Запросы в SQL с базой данных по контрактам ГИН.**
1. Представления формирует список контрактов, по которым цена заключения оказалась ниже начальной (максимальной) цены контракта (НМЦК).
Структура запроса на создание представления:
CREATE VIEW Economy_contract AS
SELECT id_contract, contract_name, n_contract, date_contract, nmck-price economy 
FROM contract
WHERE nmck-price>0 
ORDER BY economy;
SELECT * FROM economy_contract
Выполнение запроса:
<img width="974" height="639" alt="image" src="https://github.com/user-attachments/assets/356b4dd2-99f1-49aa-b872-30e97177a440" />

 
2. Запрос распределяет все контракты на три равные по количеству группы (высокая, средняя и низкая стоимость) на основе их цены заключения.
Структура запроса:
SELECT id_contract, n_contract, price, NTILE(3) OVER (ORDER BY price DESC) group_contract_price
FROM contract
Выполнение запроса:
<img width="974" height="872" alt="image" src="https://github.com/user-attachments/assets/48c0ccd7-94fe-4cf3-8653-8eef01cdf433" />

 
3. Запрос находит и выводит информацию о контрактах и конкретных этапах, имеющих самую низкую стоимость среди всех записей в базе данных.
Структура запроса:
SELECT id_contract, number_stage, sum_stage 
FROM stage 
WHERE sum_stage=(SELECT MIN(sum_stage) FROM Stage)
Выполнение запроса:
<img width="974" height="711" alt="image" src="https://github.com/user-attachments/assets/c6be9157-4135-486d-954e-13a04156a480" />

 
4. Запрос группирует этапы по контрактам и отбирает те этапы, в которых хотя бы один из этапов составляет менее 3 000 000.
Структура запроса:
SELECT id_contract, MIN(sum_stage) min_sum_stage
FROM Stage 
GROUP BY id_contract HAVING MIN(sum_stage)<3000000
ORDER BY 2
Выполнение запроса:
<img width="974" height="762" alt="image" src="https://github.com/user-attachments/assets/22eeb034-a6ba-43c0-ba8e-5aaba13d2f31" />

 
5. Запрос сопоставляет контракты с дополнительными соглашениями, фиксируя корректировку цены (уменьшение или любое другое изменение). Вычисляет разницу между первоначальной стоимостью и новой ценой для оценки изменения цены.
Структура запроса:
SELECT ag.id_contract, ag.comment, c.price, ag.new_proce_total, (c.price- ag.new_proce_total) diff
FROM additional_argmement ag
LEFT JOIN contract c on c.id_contract=ag.id_contract
WHERE comment Like ‘%уменьшение%’ OR new-price-total IS NOT NULL
Выполнение запроса:
<img width="974" height="597" alt="image" src="https://github.com/user-attachments/assets/f190626c-fddc-47e5-8bf5-e61206c1a5fb" />

 
6. Запрос вычисляет разницу между первоначальной и новой ценой конкретных этапов на основе истории их изменений.
Структура запроса:
SELECT id_contract,number_stage, old_price_stage-new_price_stage diff_stage
FROM stage_price_change 
where old_price_stage-new_price_stage>0
Выполнение запроса:
<img width="974" height="672" alt="image" src="https://github.com/user-attachments/assets/eb328c72-f579-468f-bc42-14091f906628" />

 
7. Запрос сопоставляет фактическую дату подписания акта с нормативным плановым сроком, установленным для каждого этапа и выводит в которых нет нарушений сроков.
Структура запроса:
SELECT * 
FROM (SELECT id_act, number_act, id_contract, number_stage, data_act,
CASE 
 WHEN number_stage = 1 THEN CAST('2026-04-10' AS DATE)
 WHEN number_stage = 2 THEN CAST('2026-07-10' AS DATE) 
 END AS date_act_contract 
 FROM Act
) AS sub
WHERE data_act < date_act_contract
Выполнение запроса:
<img width="971" height="916" alt="image" src="https://github.com/user-attachments/assets/b8ff1c51-8654-4779-9529-1e9b775b2e6d" />


8. Запрос вычисляет процентное соотношение стоимости выполненных работ между подрядчиком и субподрядчиком по каждому акту.
Структура запроса:
SELECT a.number_act, c.n_contract, a.number_stage, p.name_p, ROUND(Amount_act_ps/Amount_act,2)*100 percent_p, p_s.name_ps,
ROUND(1-Amount_act_ps/Amount_act,2)*100  percent_ps 
FROM act a
left join podr_sub p_s on p_s.id_ps=a.id_ps
inner join contract c on c.id_contract=a.id_contract
left join podr p on p.id_p=c.id_p
Выполнение запроса:
<img width="980" height="778" alt="image" src="https://github.com/user-attachments/assets/2d91ba9a-bd5d-499a-82e4-c86a0fc09e7d" />

 
9. Запрос проверяет наличие записей об оплате фактически выполненных работ для каждого из четырех этапов отдельно и в случае, если по этапу зафиксирован хотя бы один факт оплаты работ, ему присваивается статус полного расчета, в противном случае этап помечается, как неполностью оплаченный.
Структура запроса:
WITH pay_stage as (SELECT id_contract ,
SUM(CASE WHEN number_stage=1 and advance_or_job='job' THEN 1 ELSE 0 END) stage_1_pay,
SUM(CASE WHEN number_stage=2 and advance_or_job='job' THEN 1 ELSE 0 END ) stage_2_pay,
SUM(CASE WHEN number_stage=3 and advance_or_job='job' THEN 1 ELSE 0 END) stage_3_pay,
SUM(CASE WHEN number_stage=4 and advance_or_job='job' THEN 1 ELSE 0 END ) stage_4_pay
FROM pay
WHERE advance_or_job='job' or advance_or_job='advance'
GROUP BY id_contract)
SELECT id_contract, 
CASE WHEN stage_1_pay!=0 THEN 'FULL_PAY_TYPE' ELSE 'NOT FULL' END stage_1_pay_Full_or_NotFull,
CASE WHEN stage_2_pay!=0 THEN 'FULL_PAY_TYPE' ELSE 'NOT FULL' END stage_2_pay_Full_or_NotFull,
CASE WHEN stage_3_pay!=0 THEN 'FULL_PAY_TYPE' ELSE 'NOT FULL' END stage_3_pay_Full_or_NotFull,
CASE WHEN stage_4_pay!=0 THEN 'FULL_PAY_TYPE' ELSE 'NOT FULL' END stage_4_pay_Full_or_NotFull
FROM pay_stage
Выполнение запроса:
<img width="974" height="644" alt="image" src="https://github.com/user-attachments/assets/1bb0244b-f4b3-49ae-b247-f0f1670ae7f0" />
 
 
10.  Запрос вычисляет совокупную сумму фактически произведенных платежей по каждому контракту за отчетный период 1 квартала.
Структура запроса:
SELECT id_contract, SUM(Amount_pay) pay_in_Q1
FROM pay 
WHERE EXTRACT(MONTH FROM data_pay) BETWEEN 1 AND 3
GROUP BY id_contract
Выполнение запроса:
<img width="875" height="800" alt="image" src="https://github.com/user-attachments/assets/887d806a-6525-4de9-986e-0d4d591b420e" />

 
11. Запрос сопоставляет плановую стоимость каждого этапа с суммой фактически произведенных платежей и классифицирует этапы по уровню их финансового исполнения: стопроцентное закрытие или частичное погашение обязательств.
Структура запроса:
WITH pay_stage AS (SELECT id_contract, number_stage, SUM(Amount_pay) sum_pay
FROM pay 
GROUP BY id_contract, number_stage)
SELECT s.id_contract, s.number_stage, s.sum_stage, ps.sum_pay, 
CASE 
WHEN ps.sum_pay IS NULL THEN NULL
WHEN s.sum_stage=ps.sum_pay THEN 'FULL' ELSE 'PART' END execution
FROM stage s
LEFT JOIN pay_stage ps ON ps.id_contract=s.id_contract AND ps.number_stage=s.number_stage
Выполнение запроса:
<img width="983" height="813" alt="image" src="https://github.com/user-attachments/assets/9f19de33-eef1-4eda-a62d-fd5b111ac542" />

  
12. Запрос объединяет списки подрядчиков и субподрядчиков в единую таблицу, после чего рассчитывает общее количество упоминаний каждой компании для определения участников, которые находятся в обеих категориях.
Структура запроса:
WITH Company as (SELECT name_p name_comp, inn_p inn FROM podr
UNION ALL
SELECT name_ps name_comp, inn_sp inn FROM podr_sub)
SELECT name_comp,inn, COUNT(*) cnt_comp FROM company GROUP BY name_comp,inn ORDER BY 3 DESC 
Выполнение запроса:
<img width="803" height="573" alt="image" src="https://github.com/user-attachments/assets/095d1175-a3f8-4936-b03e-768c12d590d3" />

 
13. Запрос формирует перечень договоров, в которых фигурируют организации в одном из контрактов в статусе как подрядчика, а в другом в роли субподрядчика.
Структура запроса:
WITH podr_and_subpodr AS (SELECT DISTINCT p.inn_p inn
FROM podr p
WHERE EXISTS (SELECT 1 FROM act a
INNER JOIN podr_sub p_s ON a.id_ps = p_s.id_ps
WHERE p_s.inn_sp = p.inn_p))
SELECT DISTINCT c.n_contract, p.name_p, p_s.name_ps FROM contract c
INNER JOIN podr p ON p.id_p=c.id_p
INNER JOIN act a ON a.id_contract=c.id_contract
INNER JOIN podr_sub p_s ON p_s.id_ps=a.id_ps
WHERE inn_p IN (SELECT inn FROM podr_and_subpodr) OR inn_sp IN (SELECT inn FROM podr_and_subpodr)
Выполнение запроса:
<img width="852" height="439" alt="image" src="https://github.com/user-attachments/assets/2f4d6377-84b0-464c-8c19-8b2f3cc13a11" />

 
14. Два запроса находят для каждого договора дату самой последней оплаты.
Структура запросов:
SELECT DISTINCT id_contract, FIRST_VALUE(data_pay) 
OVER (PARTITION BY id_contract ORDER BY data_pay DESC) last_date_pay
FROM pay ORDER BY id_contract;
SELECT id_contract, MAX(data_pay) last_date_pay
FROM pay
GROUP BY id_contract ORDER BY id_contract
Выполнение запросов:
<img width="714" height="578" alt="image" src="https://github.com/user-attachments/assets/e83e1371-a802-43e6-bc57-6ac0de7af323" />

 
15. Запрос обновляет текущую стоимость этапов в основной таблице этапов, перенося в нее новые значения цен из таблицы изменений стоимости этапов.
Структура запроса:
UPDATE stage s
SET sum_stage = spc.new_price_stage
FROM stage_price_change spc
WHERE s.id_contract = spc.id_contract AND s.number_stage = spc.number_stage
Выполнение запроса:
<img width="922" height="563" alt="image" src="https://github.com/user-attachments/assets/060ab9ab-d4b8-424d-94e2-860a5934f567" />


16. Запрос формирует витрину данных по каждому контракту, агрегируя показатели на всех ключевых стадиях: от начальной цены (НМЦК) и итогов торгов до текущей стоимости этапов, объемов приянтых работ по актам и фактически оплаченным сумам.
Структура запроса:
SELECT c.n_contract, c.contract_name, c.nmck, c.price, (c.nmck - c.price) economy,
s.current_price, c.price-s.current_price diff_price,
a.total_act, ROUND(a.total_act/s.current_price,3)*100 execution_act,
p.total_pay, ROUND(p.total_pay/s.current_price,3)*100 execution_pay
FROM contract c
LEFT JOIN (SELECT id_contract, SUM(sum_stage) current_price FROM stage GROUP BY id_contract) s ON s.id_contract = c.id_contract
LEFT JOIN (SELECT id_contract, SUM(amount_act) total_act FROM act GROUP BY id_contract) a ON a.id_contract = c.id_contract
LEFT JOIN (SELECT id_contract, SUM(amount_pay) total_pay FROM pay GROUP BY id_contract) p ON p.id_contract = c.id_contract
ORDER BY c.id_contract;
Выполнение запроса:
<img width="1585" height="728" alt="image" src="https://github.com/user-attachments/assets/349177ec-5bef-4cce-9a9f-ac84a5fa212f" />

 

