--
-- PostgreSQL database dump
--

\restrict WPVn8GINuvbrsppNwqnEhPWPbzy0G7OY2yn0bh0ZJa9lckReHyXYJ1YeaYZi5yZ

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

-- Started on 2026-07-05 20:58:08

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 232 (class 1259 OID 16674)
-- Name: act; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.act (
    id_act integer NOT NULL,
    number_act integer NOT NULL,
    id_contract integer NOT NULL,
    number_stage integer NOT NULL,
    data_act date NOT NULL,
    amount_act numeric(10,2),
    amount_act_p numeric(10,2),
    id_ps integer NOT NULL,
    amount_act_ps numeric(10,2)
);


ALTER TABLE public.act OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16673)
-- Name: act_id_act_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.act_id_act_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.act_id_act_seq OWNER TO postgres;

--
-- TOC entry 4993 (class 0 OID 0)
-- Dependencies: 231
-- Name: act_id_act_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.act_id_act_seq OWNED BY public.act.id_act;


--
-- TOC entry 226 (class 1259 OID 16502)
-- Name: additional_agreement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.additional_agreement (
    id_aa integer NOT NULL,
    id_contract integer NOT NULL,
    add_arg integer,
    date_add_arg date NOT NULL,
    comment character varying(255),
    new_price_total numeric(10,2)
);


ALTER TABLE public.additional_agreement OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16501)
-- Name: additional_agreement_id_aa_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.additional_agreement_id_aa_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.additional_agreement_id_aa_seq OWNER TO postgres;

--
-- TOC entry 4994 (class 0 OID 0)
-- Dependencies: 225
-- Name: additional_agreement_id_aa_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.additional_agreement_id_aa_seq OWNED BY public.additional_agreement.id_aa;


--
-- TOC entry 222 (class 1259 OID 16466)
-- Name: contract; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contract (
    id_contract integer NOT NULL,
    contract_name character varying(255) NOT NULL,
    n_contract character varying(255) NOT NULL,
    date_contract date NOT NULL,
    nmck numeric(10,2) NOT NULL,
    price numeric(10,2),
    id_p integer NOT NULL
);


ALTER TABLE public.contract OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16465)
-- Name: contract_id_contract_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contract_id_contract_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.contract_id_contract_seq OWNER TO postgres;

--
-- TOC entry 4995 (class 0 OID 0)
-- Dependencies: 221
-- Name: contract_id_contract_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contract_id_contract_seq OWNED BY public.contract.id_contract;


--
-- TOC entry 224 (class 1259 OID 16497)
-- Name: economy_contract; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.economy_contract AS
 SELECT id_contract,
    contract_name,
    n_contract,
    date_contract,
    (nmck - price) AS economy
   FROM public.contract
  WHERE ((nmck - price) > (0)::numeric)
  ORDER BY (nmck - price);


ALTER VIEW public.economy_contract OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 16708)
-- Name: pay; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pay (
    id_pay integer NOT NULL,
    id_act integer,
    advance_or_job character varying(7),
    id_contract integer NOT NULL,
    number_stage integer NOT NULL,
    data_pay date NOT NULL,
    amount_pay numeric(10,2)
);


ALTER TABLE public.pay OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16707)
-- Name: pay_id_pay_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pay_id_pay_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pay_id_pay_seq OWNER TO postgres;

--
-- TOC entry 4996 (class 0 OID 0)
-- Dependencies: 233
-- Name: pay_id_pay_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pay_id_pay_seq OWNED BY public.pay.id_pay;


--
-- TOC entry 220 (class 1259 OID 16423)
-- Name: podr; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.podr (
    id_p integer NOT NULL,
    name_p character varying(255) NOT NULL,
    inn_p integer NOT NULL
);


ALTER TABLE public.podr OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16422)
-- Name: podr_id_p_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.podr_id_p_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.podr_id_p_seq OWNER TO postgres;

--
-- TOC entry 4997 (class 0 OID 0)
-- Dependencies: 219
-- Name: podr_id_p_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.podr_id_p_seq OWNED BY public.podr.id_p;


--
-- TOC entry 230 (class 1259 OID 16642)
-- Name: podr_sub; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.podr_sub (
    id_ps integer NOT NULL,
    name_ps character varying(255) NOT NULL,
    inn_sp integer NOT NULL
);


ALTER TABLE public.podr_sub OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16641)
-- Name: podr_sub_id_ps_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.podr_sub_id_ps_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.podr_sub_id_ps_seq OWNER TO postgres;

--
-- TOC entry 4998 (class 0 OID 0)
-- Dependencies: 229
-- Name: podr_sub_id_ps_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.podr_sub_id_ps_seq OWNED BY public.podr_sub.id_ps;


--
-- TOC entry 223 (class 1259 OID 16485)
-- Name: stage; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stage (
    id_contract integer NOT NULL,
    number_stage integer NOT NULL,
    sum_stage numeric(10,2),
    advance numeric(10,2)
);


ALTER TABLE public.stage OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16602)
-- Name: stage_price_change; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stage_price_change (
    id_change integer NOT NULL,
    id_contract integer NOT NULL,
    number_stage integer NOT NULL,
    id_aa integer NOT NULL,
    old_price_stage integer NOT NULL,
    new_price_stage integer NOT NULL
);


ALTER TABLE public.stage_price_change OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16601)
-- Name: stage_price_change_id_change_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stage_price_change_id_change_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.stage_price_change_id_change_seq OWNER TO postgres;

--
-- TOC entry 4999 (class 0 OID 0)
-- Dependencies: 227
-- Name: stage_price_change_id_change_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.stage_price_change_id_change_seq OWNED BY public.stage_price_change.id_change;


--
-- TOC entry 4798 (class 2604 OID 16677)
-- Name: act id_act; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.act ALTER COLUMN id_act SET DEFAULT nextval('public.act_id_act_seq'::regclass);


--
-- TOC entry 4795 (class 2604 OID 16505)
-- Name: additional_agreement id_aa; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.additional_agreement ALTER COLUMN id_aa SET DEFAULT nextval('public.additional_agreement_id_aa_seq'::regclass);


--
-- TOC entry 4794 (class 2604 OID 16469)
-- Name: contract id_contract; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contract ALTER COLUMN id_contract SET DEFAULT nextval('public.contract_id_contract_seq'::regclass);


--
-- TOC entry 4799 (class 2604 OID 16711)
-- Name: pay id_pay; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pay ALTER COLUMN id_pay SET DEFAULT nextval('public.pay_id_pay_seq'::regclass);


--
-- TOC entry 4793 (class 2604 OID 16426)
-- Name: podr id_p; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.podr ALTER COLUMN id_p SET DEFAULT nextval('public.podr_id_p_seq'::regclass);


--
-- TOC entry 4797 (class 2604 OID 16645)
-- Name: podr_sub id_ps; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.podr_sub ALTER COLUMN id_ps SET DEFAULT nextval('public.podr_sub_id_ps_seq'::regclass);


--
-- TOC entry 4796 (class 2604 OID 16605)
-- Name: stage_price_change id_change; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stage_price_change ALTER COLUMN id_change SET DEFAULT nextval('public.stage_price_change_id_change_seq'::regclass);


--
-- TOC entry 4985 (class 0 OID 16674)
-- Dependencies: 232
-- Data for Name: act; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.act (id_act, number_act, id_contract, number_stage, data_act, amount_act, amount_act_p, id_ps, amount_act_ps) FROM stdin;
1	1	1	1	2026-03-12	1125000.00	1012500.00	2	112500.00
2	1	2	1	2026-03-12	2250000.00	1912500.00	1	337500.00
3	1	3	1	2026-03-12	2800000.00	2520000.00	3	280000.00
4	1	4	1	2026-03-12	1000000.00	850000.00	5	150000.00
5	1	5	1	2026-03-12	1250000.00	1062500.00	4	187500.00
6	1	6	1	2026-03-12	4875000.00	4143750.00	6	731250.00
7	1	7	1	2026-03-12	1700000.00	1445000.00	2	255000.00
8	1	8	1	2026-03-12	2150000.00	2042500.00	1	107500.00
9	1	9	1	2026-03-12	1500000.00	1275000.00	3	225000.00
10	1	10	1	2026-03-12	3750000.00	3562500.00	3	187500.00
11	2	1	2	2026-06-24	1125000.00	1012500.00	2	112500.00
12	2	2	2	2026-06-24	2250000.00	1912500.00	1	337500.00
13	2	3	2	2026-06-24	2800000.00	2520000.00	3	280000.00
14	2	4	2	2026-06-24	1000000.00	850000.00	5	150000.00
15	2	5	2	2026-06-24	1250000.00	1062500.00	4	187500.00
16	2	6	2	2026-06-24	4875000.00	4143750.00	6	731250.00
17	2	7	2	2026-06-24	1700000.00	1445000.00	2	255000.00
18	2	8	2	2026-06-24	2150000.00	2042500.00	1	107500.00
19	2	9	2	2026-06-24	1500000.00	1275000.00	3	225000.00
20	2	10	2	2026-06-24	3750000.00	3562500.00	3	187500.00
\.


--
-- TOC entry 4979 (class 0 OID 16502)
-- Dependencies: 226
-- Data for Name: additional_agreement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.additional_agreement (id_aa, id_contract, add_arg, date_add_arg, comment, new_price_total) FROM stdin;
1	1	1	2026-01-16	Уточнение реквизитов	\N
2	5	1	2026-01-20	Уточнение реквизитов	\N
3	1	2	2026-04-20	Уменьшение стоимости работ	4000000.00
4	7	1	2026-04-20	Уменьшение стоимости работ	6400000.00
5	2	1	2026-05-20	Перенос между этапами стоимости работ	\N
\.


--
-- TOC entry 4976 (class 0 OID 16466)
-- Dependencies: 222
-- Data for Name: contract; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contract (id_contract, contract_name, n_contract, date_contract, nmck, price, id_p) FROM stdin;
1	Поисковые работы и бурение скважины для добычи золота в месте 1	1/26	2026-01-12	5000000.00	4500000.00	2
2	Поисковые работы и бурение скважины для добычи золота в месте 2	2/26	2026-01-13	10000000.00	9000000.00	2
3	Поисковые работы и бурение скважины для добычи алмазов в месте 3	3/26	2026-01-14	12000000.00	11200000.00	3
4	Поисковые работы и бурение скважины для добычи золота в месте 4	4/26	2026-01-15	4000000.00	4000000.00	1
5	Поисковые работы и бурение скважины для добычи золота в месте 5	5/26	2026-01-16	5000000.00	5000000.00	5
6	Поисковые работы и бурение скважины для добычи золота в месте 6	6/26	2026-01-17	20000000.00	19500000.00	5
8	Поисковые работы и бурение скважины для добычи золота в месте 8	8/26	2026-01-19	9000000.00	8600000.00	2
9	Поисковые работы и бурение скважины для добычи золота в месте 9	9/26	2026-01-20	6500000.00	6000000.00	4
10	Поисковые работы и бурение скважины для добычи алмазов в месте 10	10/26	2026-01-21	15000000.00	15000000.00	5
7	Поисковые работы и бурение скважины для добычи золота в месте 7	7/26	2026-01-18	6800000.00	6800000.00	5
\.


--
-- TOC entry 4987 (class 0 OID 16708)
-- Dependencies: 234
-- Data for Name: pay; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pay (id_pay, id_act, advance_or_job, id_contract, number_stage, data_pay, amount_pay) FROM stdin;
1	\N	advance	1	1	2026-01-20	337500.00
4	\N	advance	2	1	2026-01-20	675000.00
7	\N	advance	3	1	2026-01-20	840000.00
10	\N	advance	4	1	2026-01-20	300000.00
13	\N	advance	5	1	2026-01-20	375000.00
16	\N	advance	6	1	2026-01-20	1462500.00
19	\N	advance	7	1	2026-01-20	510000.00
22	\N	advance	8	1	2026-01-20	645000.00
25	\N	advance	9	1	2026-01-20	450000.00
28	\N	advance	10	1	2026-01-20	1125000.00
2	1	job	1	1	2026-03-23	787500.00
3	\N	advance	1	2	2026-03-27	337500.00
5	2	job	2	1	2026-03-23	1575000.00
6	\N	advance	2	2	2026-03-26	675000.00
8	3	job	3	1	2026-03-23	1960000.00
9	\N	advance	3	2	2026-03-26	840000.00
11	4	job	4	1	2026-03-23	700000.00
12	\N	advance	4	2	2026-03-26	300000.00
14	5	job	5	1	2026-03-23	875000.00
15	\N	advance	5	2	2026-03-26	375000.00
17	6	job	6	1	2026-03-23	3412500.00
18	\N	advance	6	2	2026-03-26	1462500.00
20	7	job	7	1	2026-03-23	1190000.00
23	8	job	8	1	2026-03-23	1505000.00
24	\N	advance	8	2	2026-03-26	645000.00
26	9	job	9	1	2026-03-23	1050000.00
27	\N	advance	9	2	2026-03-26	450000.00
29	10	job	10	1	2026-03-23	2625000.00
30	\N	advance	10	2	2026-03-26	1125000.00
21	\N	advance	7	2	2026-03-27	480000.00
\.


--
-- TOC entry 4974 (class 0 OID 16423)
-- Dependencies: 220
-- Data for Name: podr; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.podr (id_p, name_p, inn_p) FROM stdin;
1	ООО ДОБЫЧА	0
2	ООО ЗОЛОТО	1
3	ООО БРИЛИАНТЫ	2
4	ООО БУРИМ	3
5	ГК ГЕОЛОГИЯ	4
\.


--
-- TOC entry 4983 (class 0 OID 16642)
-- Dependencies: 230
-- Data for Name: podr_sub; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.podr_sub (id_ps, name_ps, inn_sp) FROM stdin;
1	ООО ПОМОГАЕМ	10
2	ООО ДОБЫВАЕМ	20
3	ООО КОПАЕМ	30
4	ООО ПРОЕКТИРУЕМ	40
5	ООО ПАРТНТЕР	50
6	ООО БУРИМ	3
\.


--
-- TOC entry 4977 (class 0 OID 16485)
-- Dependencies: 223
-- Data for Name: stage; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stage (id_contract, number_stage, sum_stage, advance) FROM stdin;
1	1	1125000.00	337500.00
1	2	1125000.00	337500.00
1	3	1125000.00	337500.00
1	4	1125000.00	337500.00
2	1	2250000.00	675000.00
2	2	2250000.00	675000.00
2	3	2250000.00	675000.00
2	4	2250000.00	675000.00
3	1	2800000.00	840000.00
3	2	2800000.00	840000.00
3	3	2800000.00	840000.00
3	4	2800000.00	840000.00
4	1	1000000.00	300000.00
4	2	1000000.00	300000.00
4	3	1000000.00	300000.00
4	4	1000000.00	300000.00
5	1	1250000.00	375000.00
5	2	1250000.00	375000.00
5	3	1250000.00	375000.00
5	4	1250000.00	375000.00
6	1	4875000.00	1462500.00
6	2	4875000.00	1462500.00
6	3	4875000.00	1462500.00
6	4	4875000.00	1462500.00
7	1	1700000.00	510000.00
7	2	1700000.00	510000.00
7	3	1700000.00	510000.00
7	4	1700000.00	510000.00
8	1	2150000.00	645000.00
8	2	2150000.00	645000.00
8	3	2150000.00	645000.00
8	4	2150000.00	645000.00
9	1	1500000.00	450000.00
9	2	1500000.00	450000.00
9	3	1500000.00	450000.00
9	4	1500000.00	450000.00
10	1	3750000.00	1125000.00
10	2	3750000.00	1125000.00
10	3	3750000.00	1125000.00
10	4	3750000.00	1125000.00
\.


--
-- TOC entry 4981 (class 0 OID 16602)
-- Dependencies: 228
-- Data for Name: stage_price_change; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stage_price_change (id_change, id_contract, number_stage, id_aa, old_price_stage, new_price_stage) FROM stdin;
1	1	1	3	1125000	1125000
2	1	2	3	1125000	1125000
3	1	3	3	1125000	1000000
4	1	4	3	1125000	750000
5	7	1	4	1700000	1700000
6	7	2	4	1700000	1600000
7	7	3	4	1700000	1600000
8	7	4	4	1700000	1500000
9	2	2	5	2250000	1750000
10	2	3	5	2250000	2500000
11	2	4	5	2250000	2500000
\.


--
-- TOC entry 5000 (class 0 OID 0)
-- Dependencies: 231
-- Name: act_id_act_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.act_id_act_seq', 20, true);


--
-- TOC entry 5001 (class 0 OID 0)
-- Dependencies: 225
-- Name: additional_agreement_id_aa_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.additional_agreement_id_aa_seq', 5, true);


--
-- TOC entry 5002 (class 0 OID 0)
-- Dependencies: 221
-- Name: contract_id_contract_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contract_id_contract_seq', 10, true);


--
-- TOC entry 5003 (class 0 OID 0)
-- Dependencies: 233
-- Name: pay_id_pay_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pay_id_pay_seq', 30, true);


--
-- TOC entry 5004 (class 0 OID 0)
-- Dependencies: 219
-- Name: podr_id_p_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.podr_id_p_seq', 1, false);


--
-- TOC entry 5005 (class 0 OID 0)
-- Dependencies: 229
-- Name: podr_sub_id_ps_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.podr_sub_id_ps_seq', 6, true);


--
-- TOC entry 5006 (class 0 OID 0)
-- Dependencies: 227
-- Name: stage_price_change_id_change_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stage_price_change_id_change_seq', 11, true);


--
-- TOC entry 4813 (class 2606 OID 16685)
-- Name: act act_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.act
    ADD CONSTRAINT act_pkey PRIMARY KEY (id_act);


--
-- TOC entry 4807 (class 2606 OID 16510)
-- Name: additional_agreement additional_agreement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.additional_agreement
    ADD CONSTRAINT additional_agreement_pkey PRIMARY KEY (id_aa);


--
-- TOC entry 4803 (class 2606 OID 16479)
-- Name: contract contract_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contract
    ADD CONSTRAINT contract_pkey PRIMARY KEY (id_contract);


--
-- TOC entry 4815 (class 2606 OID 16717)
-- Name: pay pay_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pay
    ADD CONSTRAINT pay_pkey PRIMARY KEY (id_pay);


--
-- TOC entry 4801 (class 2606 OID 16431)
-- Name: podr podr_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.podr
    ADD CONSTRAINT podr_pkey PRIMARY KEY (id_p);


--
-- TOC entry 4811 (class 2606 OID 16650)
-- Name: podr_sub podr_sub_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.podr_sub
    ADD CONSTRAINT podr_sub_pkey PRIMARY KEY (id_ps);


--
-- TOC entry 4805 (class 2606 OID 16491)
-- Name: stage stage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stage
    ADD CONSTRAINT stage_pkey PRIMARY KEY (id_contract, number_stage);


--
-- TOC entry 4809 (class 2606 OID 16613)
-- Name: stage_price_change stage_price_change_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stage_price_change
    ADD CONSTRAINT stage_price_change_pkey PRIMARY KEY (id_change);


--
-- TOC entry 4821 (class 2606 OID 16686)
-- Name: act act_id_contract_number_stage_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.act
    ADD CONSTRAINT act_id_contract_number_stage_fkey FOREIGN KEY (id_contract, number_stage) REFERENCES public.stage(id_contract, number_stage) ON DELETE CASCADE;


--
-- TOC entry 4822 (class 2606 OID 16691)
-- Name: act act_id_ps_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.act
    ADD CONSTRAINT act_id_ps_fkey FOREIGN KEY (id_ps) REFERENCES public.podr_sub(id_ps) ON DELETE RESTRICT;


--
-- TOC entry 4818 (class 2606 OID 16511)
-- Name: additional_agreement additional_agreement_id_contract_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.additional_agreement
    ADD CONSTRAINT additional_agreement_id_contract_fkey FOREIGN KEY (id_contract) REFERENCES public.contract(id_contract) ON DELETE CASCADE;


--
-- TOC entry 4816 (class 2606 OID 16480)
-- Name: contract contract_id_p_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contract
    ADD CONSTRAINT contract_id_p_fkey FOREIGN KEY (id_p) REFERENCES public.podr(id_p) ON DELETE CASCADE;


--
-- TOC entry 4823 (class 2606 OID 16718)
-- Name: pay pay_id_act_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pay
    ADD CONSTRAINT pay_id_act_fkey FOREIGN KEY (id_act) REFERENCES public.act(id_act) ON DELETE CASCADE;


--
-- TOC entry 4824 (class 2606 OID 16723)
-- Name: pay pay_id_contract_number_stage_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pay
    ADD CONSTRAINT pay_id_contract_number_stage_fkey FOREIGN KEY (id_contract, number_stage) REFERENCES public.stage(id_contract, number_stage) ON DELETE CASCADE;


--
-- TOC entry 4817 (class 2606 OID 16492)
-- Name: stage stage_id_contract_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stage
    ADD CONSTRAINT stage_id_contract_fkey FOREIGN KEY (id_contract) REFERENCES public.contract(id_contract) ON DELETE CASCADE;


--
-- TOC entry 4819 (class 2606 OID 16614)
-- Name: stage_price_change stage_price_change_id_aa_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stage_price_change
    ADD CONSTRAINT stage_price_change_id_aa_fkey FOREIGN KEY (id_aa) REFERENCES public.additional_agreement(id_aa) ON DELETE CASCADE;


--
-- TOC entry 4820 (class 2606 OID 16619)
-- Name: stage_price_change stage_price_change_id_contract_number_stage_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stage_price_change
    ADD CONSTRAINT stage_price_change_id_contract_number_stage_fkey FOREIGN KEY (id_contract, number_stage) REFERENCES public.stage(id_contract, number_stage) ON DELETE CASCADE;


-- Completed on 2026-07-05 20:58:08

--
-- PostgreSQL database dump complete
--

\unrestrict WPVn8GINuvbrsppNwqnEhPWPbzy0G7OY2yn0bh0ZJa9lckReHyXYJ1YeaYZi5yZ

