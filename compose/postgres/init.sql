--
-- PostgreSQL database dump
--

\restrict h0qn6ifAjmIvLcLvLwGw6MBPnSWw4MPg3nT5c9yjB080uKQtmHl2Fj2MtFoWpmx

-- Dumped from database version 15.14 (Debian 15.14-1.pgdg13+1)
-- Dumped by pg_dump version 16.10 (Ubuntu 16.10-0ubuntu0.24.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE ONLY public.wards DROP CONSTRAINT wards_municipality_id_fkey;
ALTER TABLE ONLY public.province DROP CONSTRAINT province_country_id_fkey;
ALTER TABLE ONLY public.positive_contributions DROP CONSTRAINT positive_contributions_candidate_details_id_fkey;
ALTER TABLE ONLY public.political_experiences DROP CONSTRAINT political_experiences_candidate_details_id_fkey;
ALTER TABLE ONLY public.municipalities DROP CONSTRAINT municipalities_district_id_fkey;
ALTER TABLE ONLY public.district DROP CONSTRAINT district_province_id_fkey;
ALTER TABLE ONLY public.controversies DROP CONSTRAINT controversies_candidate_details_id_fkey;
ALTER TABLE ONLY public.candidate DROP CONSTRAINT candidate_province_id_fkey;
ALTER TABLE ONLY public.candidate DROP CONSTRAINT candidate_district_id_fkey;
ALTER TABLE ONLY public.candidate_details DROP CONSTRAINT candidate_details_candidate_id_fkey;
ALTER TABLE ONLY public.campaign_focuses DROP CONSTRAINT campaign_focuses_candidate_details_id_fkey;
ALTER TABLE ONLY public.achievements DROP CONSTRAINT achievements_candidate_details_id_fkey;
DROP INDEX public.ix_wards_id;
DROP INDEX public.ix_users_id;
DROP INDEX public.ix_province_id;
DROP INDEX public.ix_municipalities_id;
DROP INDEX public.ix_district_id;
DROP INDEX public.ix_country_id;
DROP INDEX public.ix_candidate_id;
DROP INDEX public.ix_candidate_details_id;
ALTER TABLE ONLY public.wards DROP CONSTRAINT wards_pkey;
ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
ALTER TABLE ONLY public.province DROP CONSTRAINT province_pkey;
ALTER TABLE ONLY public.province DROP CONSTRAINT province_name_key;
ALTER TABLE ONLY public.positive_contributions DROP CONSTRAINT positive_contributions_pkey;
ALTER TABLE ONLY public.political_experiences DROP CONSTRAINT political_experiences_pkey;
ALTER TABLE ONLY public.municipalities DROP CONSTRAINT municipalities_pkey;
ALTER TABLE ONLY public.district DROP CONSTRAINT district_pkey;
ALTER TABLE ONLY public.country DROP CONSTRAINT country_pkey;
ALTER TABLE ONLY public.country DROP CONSTRAINT country_name_key;
ALTER TABLE ONLY public.country DROP CONSTRAINT country_code_key;
ALTER TABLE ONLY public.controversies DROP CONSTRAINT controversies_pkey;
ALTER TABLE ONLY public.candidate DROP CONSTRAINT candidate_pkey;
ALTER TABLE ONLY public.candidate_details DROP CONSTRAINT candidate_details_pkey;
ALTER TABLE ONLY public.campaign_focuses DROP CONSTRAINT campaign_focuses_pkey;
ALTER TABLE ONLY public.alembic_version DROP CONSTRAINT alembic_version_pkc;
ALTER TABLE ONLY public.achievements DROP CONSTRAINT achievements_pkey;
ALTER TABLE public.wards ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.province ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.positive_contributions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.political_experiences ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.municipalities ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.district ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.country ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.controversies ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.candidate_details ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.candidate ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.campaign_focuses ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.achievements ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE public.wards_id_seq;
DROP TABLE public.wards;
DROP SEQUENCE public.users_id_seq;
DROP TABLE public.users;
DROP SEQUENCE public.province_id_seq;
DROP TABLE public.province;
DROP SEQUENCE public.positive_contributions_id_seq;
DROP TABLE public.positive_contributions;
DROP SEQUENCE public.political_experiences_id_seq;
DROP TABLE public.political_experiences;
DROP SEQUENCE public.municipalities_id_seq;
DROP TABLE public.municipalities;
DROP SEQUENCE public.district_id_seq;
DROP TABLE public.district;
DROP SEQUENCE public.country_id_seq;
DROP TABLE public.country;
DROP SEQUENCE public.controversies_id_seq;
DROP TABLE public.controversies;
DROP SEQUENCE public.candidate_id_seq;
DROP SEQUENCE public.candidate_details_id_seq;
DROP TABLE public.candidate_details;
DROP TABLE public.candidate;
DROP SEQUENCE public.campaign_focuses_id_seq;
DROP TABLE public.campaign_focuses;
DROP TABLE public.alembic_version;
DROP SEQUENCE public.achievements_id_seq;
DROP TABLE public.achievements;
DROP TYPE public.municipalitycategoryenum;
--
-- Name: municipalitycategoryenum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.municipalitycategoryenum AS ENUM (
    'METROPOLITAN',
    'SUB_METROPOLITAN',
    'MUNICIPALITY',
    'RURAL_MUNICIPALITY'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: achievements; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.achievements (
    id bigint NOT NULL,
    candidate_details_id bigint,
    description text
);


--
-- Name: achievements_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.achievements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: achievements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.achievements_id_seq OWNED BY public.achievements.id;


--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


--
-- Name: campaign_focuses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.campaign_focuses (
    id bigint NOT NULL,
    candidate_details_id bigint,
    title character varying NOT NULL,
    description text,
    image_url character varying,
    priority integer
);


--
-- Name: campaign_focuses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.campaign_focuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: campaign_focuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.campaign_focuses_id_seq OWNED BY public.campaign_focuses.id;


--
-- Name: candidate; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.candidate (
    id bigint NOT NULL,
    election_type character varying(100) NOT NULL,
    name character varying(255) NOT NULL,
    age integer,
    gender character varying(20),
    nationality character varying(100) NOT NULL,
    party character varying(255),
    constituency character varying(255),
    source_file character varying(255),
    image character varying(500),
    province_id bigint,
    district_id bigint
);


--
-- Name: COLUMN candidate.image; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.candidate.image IS 'Store MinIO image URL';


--
-- Name: candidate_details; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.candidate_details (
    id bigint NOT NULL,
    candidate_id bigint NOT NULL,
    overall_rating double precision,
    total_ratings integer,
    past_elections json,
    social_links json,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone
);


--
-- Name: candidate_details_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.candidate_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: candidate_details_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.candidate_details_id_seq OWNED BY public.candidate_details.id;


--
-- Name: candidate_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.candidate_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: candidate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.candidate_id_seq OWNED BY public.candidate.id;


--
-- Name: controversies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.controversies (
    id bigint NOT NULL,
    candidate_details_id bigint,
    title character varying NOT NULL,
    description text,
    image_url character varying,
    date timestamp without time zone,
    severity character varying
);


--
-- Name: controversies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.controversies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: controversies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.controversies_id_seq OWNED BY public.controversies.id;


--
-- Name: country; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.country (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    code character varying(10),
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: country_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.country_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: country_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.country_id_seq OWNED BY public.country.id;


--
-- Name: district; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.district (
    id bigint NOT NULL,
    province_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    area_sq_km character varying(50),
    website character varying(255),
    headquarter character varying(255)
);


--
-- Name: district_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.district_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: district_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.district_id_seq OWNED BY public.district.id;


--
-- Name: municipalities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.municipalities (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    district_id bigint NOT NULL,
    category public.municipalitycategoryenum NOT NULL,
    area_sq_km character varying(50),
    website character varying(255)
);


--
-- Name: municipalities_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.municipalities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: municipalities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.municipalities_id_seq OWNED BY public.municipalities.id;


--
-- Name: political_experiences; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.political_experiences (
    id bigint NOT NULL,
    candidate_details_id bigint,
    title character varying NOT NULL,
    description text,
    image_url character varying,
    year integer
);


--
-- Name: political_experiences_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.political_experiences_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: political_experiences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.political_experiences_id_seq OWNED BY public.political_experiences.id;


--
-- Name: positive_contributions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.positive_contributions (
    id bigint NOT NULL,
    candidate_details_id bigint,
    title character varying NOT NULL,
    description text,
    image_url character varying,
    date timestamp without time zone,
    impact character varying
);


--
-- Name: positive_contributions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.positive_contributions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: positive_contributions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.positive_contributions_id_seq OWNED BY public.positive_contributions.id;


--
-- Name: province; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.province (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    area_sq_km character varying(50),
    website character varying(255),
    headquarter character varying(255),
    country_id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: province_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.province_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: province_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.province_id_seq OWNED BY public.province.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    password character varying(200) NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: wards; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.wards (
    id integer NOT NULL,
    name character varying NOT NULL,
    number integer NOT NULL,
    municipality_id integer NOT NULL
);


--
-- Name: wards_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.wards_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.wards_id_seq OWNED BY public.wards.id;


--
-- Name: achievements id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.achievements ALTER COLUMN id SET DEFAULT nextval('public.achievements_id_seq'::regclass);


--
-- Name: campaign_focuses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.campaign_focuses ALTER COLUMN id SET DEFAULT nextval('public.campaign_focuses_id_seq'::regclass);


--
-- Name: candidate id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.candidate ALTER COLUMN id SET DEFAULT nextval('public.candidate_id_seq'::regclass);


--
-- Name: candidate_details id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.candidate_details ALTER COLUMN id SET DEFAULT nextval('public.candidate_details_id_seq'::regclass);


--
-- Name: controversies id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.controversies ALTER COLUMN id SET DEFAULT nextval('public.controversies_id_seq'::regclass);


--
-- Name: country id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.country ALTER COLUMN id SET DEFAULT nextval('public.country_id_seq'::regclass);


--
-- Name: district id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.district ALTER COLUMN id SET DEFAULT nextval('public.district_id_seq'::regclass);


--
-- Name: municipalities id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.municipalities ALTER COLUMN id SET DEFAULT nextval('public.municipalities_id_seq'::regclass);


--
-- Name: political_experiences id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.political_experiences ALTER COLUMN id SET DEFAULT nextval('public.political_experiences_id_seq'::regclass);


--
-- Name: positive_contributions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.positive_contributions ALTER COLUMN id SET DEFAULT nextval('public.positive_contributions_id_seq'::regclass);


--
-- Name: province id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.province ALTER COLUMN id SET DEFAULT nextval('public.province_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: wards id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wards ALTER COLUMN id SET DEFAULT nextval('public.wards_id_seq'::regclass);


--
-- Data for Name: achievements; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.achievements (id, candidate_details_id, description) FROM stdin;
1	1	Awarded Citizen of the Year
\.


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.alembic_version (version_num) FROM stdin;
049971739256
ccaacace0148
\.


--
-- Data for Name: campaign_focuses; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.campaign_focuses (id, candidate_details_id, title, description, image_url, priority) FROM stdin;
1	1	Education Reform	Improve local schools	\N	1
2	3	ggg	gf	\N	2
\.


--
-- Data for Name: candidate; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.candidate (id, election_type, name, age, gender, nationality, party, constituency, source_file, image, province_id, district_id) FROM stdin;
1	HOR	योगेश कुमार भट्टराई	56	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	12
2	HOR	खेल प्रसाद बुडाक्षेत्री	46	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (माओवादी केन्द्र)(एकल चुनाव चिन्ह)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	12
3	HOR	चन्द्र मादेन	49	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	12
4	HOR	राम बहादुर कार्की	65	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	12
5	HOR	चैतन्य  प्रकाश  केदेम	54	पुरुष	Nepali	लोकतान्त्रिक समाजवादी पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	12
6	HOR	विक्रम लिम्वु	28	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	12
7	HOR	होम प्रसाद तुम्बाहाम्फे	56	पुरुष	Nepali	संघीय लोकतान्त्रिक राष्ट्रिय मञ्च	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	12
8	HOR	इन्द्र कुमार लिम्बू	45	पुरुष	Nepali	राष्ट्रिय जनमुक्ति पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	12
9	HOR	कृष्ण वहादुर लिम्बु	56	पुरुष	Nepali	जनसमाजवादी पार्टी नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	12
10	HOR	सन्जु कुमार पालुंवा	66	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	12
11	HOR	हरि प्रसाद बराल	69	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	12
12	HOR	वसन्त कुमार नेम्वाङ्ग	60	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
13	HOR	भीष्म राज आङदेम्वे	57	पुरुष	Nepali	नेपाली काँग्रेस	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
14	HOR	प्रेम राज लावती	49	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
15	HOR	कमल वहादुर चेम्जोङ	60	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
16	HOR	मदन कुमार पोख्रेल	49	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
17	HOR	दीन नाथ घिमिरे	61	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (मार्क्सवादी लेनिनवादी)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
18	HOR	राम कुमार तुम्रोक	44	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
19	HOR	जस बहादुर योङहाङ	74	पुरुष	Nepali	संघीय लोकतान्त्रिक राष्ट्रिय मञ्च	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
20	HOR	नरेन्द्र प्रसाद कुरुम्‍वाङ	65	पुरुष	Nepali	राष्ट्रिय जनमुक्ति पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
21	HOR	भिम बहादुर तामाङ	32	पुरुष	Nepali	जनसमाजवादी पार्टी नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
22	HOR	दल प्रसाद लिङदेन	45	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
23	HOR	दल बहादुर आङदेम्बे	40	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
24	HOR	विष्टन लावती	32	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
25	HOR	बाल कृष्ण काफ्ले	41	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
26	HOR	लाख वहादुर पालूङ्वा	39	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
27	HOR	महेश बस्नेत	62	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	3
28	HOR	कमल कुमार राई	63	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	3
29	HOR	तोया नाथ शर्मा सापकोटा	67	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	3
30	HOR	झलनाथ खनाल	72	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एकिकृत समाजबादी)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	3
31	HOR	बुद्ध लाल मेचे	52	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	3
228	HOR	कृष्‍ण राई	75	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
32	HOR	जीत कुमार मुखिया	50	पुरुष	Nepali	संघीय लोकतान्त्रिक राष्ट्रिय मञ्च	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	3
33	HOR	पदम बहादुर लिम्बु	49	पुरुष	Nepali	राष्ट्रिय जनमुक्ति पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	3
34	HOR	गणेस प्रसाद पौडेल	60	पुरुष	Nepali	नेपाली कांग्रेस (बी.पी.)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	3
35	HOR	बिक्रम पाण्डे	68	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	3
36	HOR	नेत्र प्रसाद रेग्मी	51	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	3
37	HOR	निमा तेन्जीङ शेर्पा	57	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	3
38	HOR	सुवास चन्द्र नेम्वाङ्ग	69	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	3
39	HOR	डम्बर बहादुर खड्का	47	पुरुष	Nepali	नेपाली काँग्रेस	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	3
40	HOR	याम प्रसाद लिम्ब‍ू	52	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	3
41	HOR	गणेश प्रसाद दुलाल	61	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	3
42	HOR	निर मणी माङमु लिम्बु	43	पुरुष	Nepali	लोकतान्त्रिक समाजवादी पार्टी, नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	3
43	HOR	मनि बहादुर लिम्वू (पापो)	51	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	3
44	HOR	गोविन्द सिंह लिम्वू	44	पुरुष	Nepali	संघीय लोकतान्त्रिक राष्ट्रिय मञ्च	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	3
45	HOR	खड्ग प्रसाद पालुंवा	59	पुरुष	Nepali	राष्ट्रिय जनमुक्ति पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	3
46	HOR	डाक प्रसाद गौतम	55	पुरुष	Nepali	नेपाली कांग्रेस (बी.पी.)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	3
47	HOR	तिलक बहादुर मगर	46	पुरुष	Nepali	सामाजिक लोकतान्त्रिक पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	3
48	HOR	याक बहादुर लिम्वू	56	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	3
49	HOR	प्रकाश सापकोटा	30	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	3
50	HOR	दिपेश बोहोरा	35	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	3
51	HOR	जुनु माखिम	56	महिला	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	3
52	HOR	अग्नि प्रसाद खरेल	61	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
53	HOR	विश्व प्रकाश शर्मा	52	पुरुष	Nepali	नेपाली काँग्रेस	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
54	HOR	राधा थापा	70	महिला	Nepali	जनता समाजवादी पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
55	HOR	ओलीन राजवंशी	57	पुरुष	Nepali	लोकतान्त्रिक समाजवादी पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
56	HOR	ठण्डबहादुर अधिकारी	47	पुरुष	Nepali	हाम्रो नेपाली पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
57	HOR	मुकुन्द दाहाल	50	पुरुष	Nepali	नेपालका लागि नेपाली पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
58	HOR	सन्तोष तामाङ्ग	39	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
59	HOR	पदममाया लिम्बु	52	महिला	Nepali	संघीय लोकतान्त्रिक राष्ट्रिय मञ्च	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
60	HOR	चित्रहाङ जबेगु	39	पुरुष	Nepali	राष्ट्रिय जनमुक्ति पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
61	HOR	राम कुमार काफ्ले	54	पुरुष	Nepali	नेपाल जनता पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
62	HOR	रमेश बास्तोला	44	पुरुष	Nepali	जनसमाजवादी पार्टी नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
63	HOR	ओमनाथ भण्डारी	40	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
64	HOR	बिकास राजवंशी	25	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
65	HOR	केन्द्र कुमारी दाहाल	38	महिला	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
66	HOR	विदुर कुमार खतिवडा	45	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
67	HOR	देव राज घिमिरे	66	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
68	HOR	हरि कुमार राना मगर	63	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (माओवादी केन्द्र)(एकल चुनाव चिन्ह)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
69	HOR	रामसुफल कामती	63	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
70	HOR	महेन्द्र खायमली	50	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
71	HOR	त्रीनारायण राजवंशी	61	पुरुष	Nepali	लोकतान्त्रिक समाजवादी पार्टी, नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
72	HOR	ज्ञानेन्द्रराज कार्की	36	पुरुष	Nepali	नेपालका लागि नेपाली पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
73	HOR	सन्तोष घिमिरे	39	पुरुष	Nepali	नेपाल विवेकशील पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
74	HOR	अकल बहादुर तामाङ्ग	52	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
75	HOR	रेश्मा चेम्जोङ	37	महिला	Nepali	संघीय लोकतान्त्रिक राष्ट्रिय मञ्च	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
76	HOR	प्रशुराम मगर	55	पुरुष	Nepali	राष्ट्रिय जनमुक्ति पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
77	HOR	नारायण बहादुर भारती	52	पुरुष	Nepali	नेपाली कांग्रेस (बी.पी.)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
78	HOR	कृष्ण प्रसाद गौतम	31	पुरुष	Nepali	जनसमाजवादी पार्टी नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
79	HOR	रुद्र प्रसाद गिरी	54	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
80	HOR	भद्र प्रसाद नेपाल	46	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
81	HOR	खेमराज दहाल	60	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
82	HOR	कुमार भट्टराई	50	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
83	HOR	राज कुमार तामाङ लामा	47	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
84	HOR	चेत कुमार खनाल	47	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
85	HOR	कृष्ण प्रसाद सिटौला	72	पुरुष	Nepali	नेपाली काँग्रेस	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
86	HOR	वीर बहादुर राई	70	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
87	HOR	राजेन्द्र प्रसाद लिङ्देन	57	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
88	HOR	कृष्ण गोपाल छुस्यावाग	55	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
89	HOR	देवेन्द्र किशोर ढुंगाना	60	पुरुष	Nepali	लोकतान्त्रिक समाजवादी पार्टी, नेपाल	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
90	HOR	भोट लाल राजवंशी	34	पुरुष	Nepali	जनमत पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
91	HOR	चूडामणि अधिकारी	61	पुरुष	Nepali	मौलिक जरोकिलो पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
92	HOR	योगेन्द्र प्रसाद खनाल	41	पुरुष	Nepali	हाम्रो नेपाली पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
93	HOR	देवी  रमण भट्टराई	68	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी नेपाल	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
94	HOR	श्याम बहादुर लिम्वु	36	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
95	HOR	डम्बर बहादुर लिम्बु	44	पुरुष	Nepali	संघीय लोकतान्त्रिक राष्ट्रिय मञ्च	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
96	HOR	गजेन्द्र लिम्बु	34	पुरुष	Nepali	राष्ट्रिय जनमुक्ति पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
97	HOR	भक्ती प्रसाद पनेरु	42	पुरुष	Nepali	नेपाली कांग्रेस (बी.पी.)	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
98	HOR	ओम प्रकाश खरेल	43	पुरुष	Nepali	सचेत नेपाली पार्टी(एकल चुनाव चिन्ह)	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
99	HOR	प्रकाश पाठक	34	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
100	HOR	प्रेम प्रसाद खनाल	37	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
101	HOR	डम्बर बहादुर गिरी	39	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
102	HOR	मनोरथ राजवंशी	47	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
103	HOR	लाल प्रसाद साँवा लिम्बू	55	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
104	HOR	देउ कुमार थेवे	57	पुरुष	Nepali	नेपाली काँग्रेस	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
105	HOR	हर्कराज राई	63	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
106	HOR	विक्रम कासिछ्‌वा	46	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
107	HOR	ग्यासुदिन मिया	53	पुरुष	Nepali	लोकतान्त्रिक समाजवादी पार्टी, नेपाल	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
108	HOR	सत्य नारायण राजवंशी	45	पुरुष	Nepali	जनमत पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
109	HOR	युक्त प्रसाद भेटवाल	61	पुरुष	Nepali	हाम्रो नेपाली पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
110	HOR	दिलिप धिमाल	37	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
111	HOR	लाहान सिं तुम्बापो	64	पुरुष	Nepali	संघीय लोकतान्त्रिक राष्ट्रिय मञ्च	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
112	HOR	मन कुमार ताप्मादेन (लिम्बु)	28	पुरुष	Nepali	राष्ट्रिय जनमुक्ति पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
113	HOR	दुर्गा प्रसाद घिमिरे	58	पुरुष	Nepali	नेपाली कांग्रेस (बी.पी.)	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
114	HOR	शम्भु प्रसाद ढकाल	46	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
115	HOR	पूर्ण कमार लिम्बु (फेजुङ्ग)	49	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
116	HOR	लक्ष्मीनारायण खनाल	43	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
117	HOR	नन्द राज राई	67	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
118	HOR	खुश्बु ओली	32	महिला	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
119	HOR	किरण श्रेष्ठ	26	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
120	HOR	कमल बहादुर पौड्याल	56	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
121	HOR	के.पी शर्मा ओली	70	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
122	HOR	खगेन्द्र अधिकारी	48	पुरुष	Nepali	नेपाली काँग्रेस	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
123	HOR	ओम माया आङदेम्वे	46	महिला	Nepali	जनता समाजवादी पार्टी, नेपाल	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
124	HOR	रुद्र प्रसाद दाहाल	46	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
125	HOR	चन्द्र प्रसाद राजवंशी	43	पुरुष	Nepali	लोकतान्त्रिक समाजवादी पार्टी, नेपाल	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
126	HOR	भीम राजवंशी	49	पुरुष	Nepali	जनमत पार्टी	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
127	HOR	सान बहादुर मेचे	39	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
128	HOR	कविन्द्र शेर्मा लिम्बु	63	पुरुष	Nepali	संघीय लोकतान्त्रिक राष्ट्रिय मञ्च	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
129	HOR	राजन चुडाल	42	पुरुष	Nepali	नेश्नलिष्ट पिपल्स पार्टी	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
130	HOR	पदम बहादुर जवेगु	45	पुरुष	Nepali	राष्ट्रिय जनमुक्ति पार्टी	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
131	HOR	सेखरनाथ सेडाई	45	पुरुष	Nepali	नेपाली कांग्रेस (बी.पी.)	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
132	HOR	राम प्रसाद पाठक	40	पुरुष	Nepali	सचेत नेपाली पार्टी(एकल चुनाव चिन्ह)	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
133	HOR	शुरेस कुमार पोखरेल	49	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
134	HOR	कल्पना लावती	45	महिला	Nepali	स्वतन्त्र	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
135	HOR	रोहीत प्रसाद पौड्याल	51	पुरुष	Nepali	स्वतन्त्र	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
136	HOR	दिपक कुमार पाठक	44	पुरुष	Nepali	स्वतन्त्र	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
137	HOR	रामचन्द्र बानिया	52	पुरुष	Nepali	स्वतन्त्र	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
138	HOR	भेषराज भट्टराई	41	पुरुष	Nepali	स्वतन्त्र	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
139	HOR	सिताराम पोख्रेल	52	पुरुष	Nepali	स्वतन्त्र	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
140	HOR	तिर्थेश्‍वर चौधरी	25	पुरुष	Nepali	स्वतन्त्र	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
141	HOR	शान्ता अधिकारी	47	महिला	Nepali	स्वतन्त्र	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
142	HOR	इन्द्रमणी दाहाल	51	पुरुष	Nepali	स्वतन्त्र	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
143	HOR	केदार नाथ चापागाई	37	पुरुष	Nepali	स्वतन्त्र	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
144	HOR	रेवती रमण खनाल	53	पुरुष	Nepali	स्वतन्त्र	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
145	HOR	तुलसी राम काफ्ले	55	पुरुष	Nepali	स्वतन्त्र	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	4
146	HOR	राजेन्द्र प्रसाद गौत्तम	59	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	9
147	HOR	दिपक खड्का	51	पुरुष	Nepali	नेपाली काँग्रेस	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	9
148	HOR	दिपक कुमार राई (याक्खा)	45	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	9
149	HOR	भोला मान कार्की	51	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	9
150	HOR	टिका राम शाही	79	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	9
151	HOR	देवेन्द्र कुमार (रिल्ली) घले	55	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	9
152	HOR	राज कुमार लिम्बु	35	पुरुष	Nepali	संघीय लोकतान्त्रिक राष्ट्रिय मञ्च	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	9
153	HOR	बिनोद घिमिरे	60	पुरुष	Nepali	नेश्नलिष्ट पिपल्स पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	9
154	HOR	कृष्ण कुमार राई(कुलुङ)	65	पुरुष	Nepali	राष्ट्रिय जनमुक्ति पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	9
155	HOR	भक्त नारायण श्रेष्ठ	55	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	9
156	HOR	प्रविन कार्की	30	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	9
157	HOR	तेन्जी भोटिया	33	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	9
158	HOR	बिजय सुब्बा	64	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
159	HOR	सिता गुरुङ्ग	46	महिला	Nepali	नेपाली काँग्रेस	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
160	HOR	नारायण मान गुरुङ्ग	55	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
161	HOR	युव राम गौतम	87	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
162	HOR	गौरी प्रसाद कन्दङवा	69	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
163	HOR	गंगा वहादुर चोङवाङ् लिम्बु	36	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
164	HOR	विष्णु कुमार चोङवाङ	31	पुरुष	Nepali	संघीय लोकतान्त्रिक राष्ट्रिय मञ्च	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
165	HOR	राजेन्द्र कुमार लिम्बू	66	पुरुष	Nepali	राष्ट्रिय जनमुक्ति पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
166	HOR	टंक प्रसाद भट्टराई	60	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी मार्क्सवादी (पुष्पलाल)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
167	HOR	शुसन चोङवाङ लिम्बु	38	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
307	HOR	विजय कुमार राई	62	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
168	HOR	शेरधन राई	51	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	1
169	HOR	सुदन किराती	43	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (माओवादी केन्द्र)(एकल चुनाव चिन्ह)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	1
170	HOR	ध्रुव छाङछा दुमिहाङ्ग राई	35	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	1
171	HOR	जितेन्द्र घले	49	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	1
172	HOR	रमेश प्रसाद ओझा	48	पुरुष	Nepali	हाम्रो नेपाली पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	1
173	HOR	डा.सुरेश बस्नेत	45	पुरुष	Nepali	नेपालका लागि नेपाली पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	1
174	HOR	चन्द्र प्रसाद राई	44	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	1
175	HOR	ऋषि धन राई	47	पुरुष	Nepali	खम्बुवान राष्ट्रिय मोर्चा नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	1
176	HOR	सनम छिरिङ शेर्पा	40	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	1
177	HOR	शक्ति राज राई	43	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	1
178	HOR	महेश योञ्जन	56	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	1
179	HOR	दिलिप कुमार खतिवडा	57	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	1
180	HOR	राजेन्द्र कुमार राई	56	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	2
181	HOR	सुनील बहादुर थापा	63	पुरुष	Nepali	नेपाली काँग्रेस	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	2
182	HOR	कुमार बहादुर थापा	70	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	2
183	HOR	विश्वा मित्र लावती	45	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	2
184	HOR	आराम कुमार लिम्बु	35	पुरुष	Nepali	संघीय लोकतान्त्रिक राष्ट्रिय मञ्च	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	2
185	HOR	रमेश राई	29	पुरुष	Nepali	एकीकृत शक्ति नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	2
186	HOR	हेमराज भण्डारी	46	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	2
187	HOR	घनश्याम खतीवडा	60	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
188	HOR	डिग बहादुर लिम्वु	59	पुरुष	Nepali	नेपाली काँग्रेस	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
189	HOR	होम नाथ गौतम	44	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
190	HOR	लक्ष्मी प्रसाद कवां	45	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
191	HOR	राजेन्द्र प्रसाद पौडेल	41	पुरुष	Nepali	हाम्रो नेपाली पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
192	HOR	सुरज लिम्वु	38	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
193	HOR	हर्क मान सम्वाहाम्फे	65	पुरुष	Nepali	संघीय लोकतान्त्रिक राष्ट्रिय मञ्च	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
194	HOR	बुद्ध माया लिम्बु	39	महिला	Nepali	राष्ट्रिय जनमुक्ति पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
195	HOR	कमल बहादुर श्रेष्ठ	36	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
196	HOR	तिलक बहादुर मगर	40	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
197	HOR	मनिसा सुवेदी	35	महिला	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
198	HOR	फूल कुमारी पंडित राई	29	महिला	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
199	HOR	निलु लिम्बु	33	महिला	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
200	HOR	याम प्रसाद दाहाल	57	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
201	HOR	ऋषिकेश पोखरेल	54	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
202	HOR	सुजाता कोइराला	68	महिला	Nepali	नेपाली काँग्रेस	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
203	HOR	गोपाल दाहाल	55	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
204	HOR	सुरेश कवाँ	33	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
205	HOR	नारायण प्रसाद गंगाई	55	पुरुष	Nepali	लोकतान्त्रिक समाजवादी पार्टी, नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
206	HOR	विनोद मणी भट्टराई	48	पुरुष	Nepali	हाम्रो नेपाली पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
207	HOR	नारायण विसंखे	43	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
208	HOR	खील बहादुर खङ्का	44	पुरुष	Nepali	संघीय लोकतान्त्रिक राष्ट्रिय मञ्च	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
209	HOR	मिना कटुवाल बुढाथोकी	57	महिला	Nepali	नेश्नलिष्ट पिपल्स पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
210	HOR	ठगेन्द्र प्रसाद न्यौपाने	34	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
211	HOR	राज कुमार सिवाकोटी	52	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
212	HOR	विशेश्‍वर ऋषिदेव	41	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
213	HOR	सुनिल कुमार साह	25	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
214	HOR	भानु भक्त ढकाल	60	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
215	HOR	शुनिल कुमार शर्मा	44	पुरुष	Nepali	नेपाली काँग्रेस	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
216	HOR	रेखा थापा	41	महिला	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
217	HOR	ओम नारायण राजवातर धामी	38	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
218	HOR	भुवन राइ	33	पुरुष	Nepali	लोकतान्त्रिक समाजवादी पार्टी, नेपाल	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
219	HOR	खगेन्द्र प्रसाद न्यौपाने	56	पुरुष	Nepali	हाम्रो नेपाली पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
220	HOR	उद्धिम बहादुर खड्का	40	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (मार्क्सवादी लेनिनवादी)	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
221	HOR	बिकेन्द्र राई	40	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
222	HOR	चन्द्रिका देवी लिम्बु	40	महिला	Nepali	संघीय लोकतान्त्रिक राष्ट्रिय मञ्च	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
223	HOR	नारायण शर्मा	54	पुरुष	Nepali	नेश्नलिष्ट पिपल्स पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
224	HOR	कमल लिम्बु	29	पुरुष	Nepali	जनसमाजवादी पार्टी नेपाल	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
225	HOR	विकास उप्रेती	40	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
226	HOR	दिनेश चापागाई	43	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
227	HOR	जय राज संयोग	50	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
229	HOR	पंकज कुमार भगत	32	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
230	HOR	गणेश बहादुर पोख्रेल	40	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
231	HOR	इन्दिरा थापा	40	महिला	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
232	HOR	कमल राजवंशी	26	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
233	HOR	प्रकाश भट्टराई	39	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
234	HOR	शिव कुमार पौडेल	56	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
235	HOR	अरविन शाह	30	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
236	HOR	इन्द्र प्रसाद सुवेदी	59	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
237	HOR	चन्द्र कला खत्रि	33	महिला	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
238	HOR	सुवास धिमाल	51	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
239	HOR	हिम प्रसाद मिश्र	58	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
240	HOR	बावु राम सुवेदी	34	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
241	HOR	रेवत कुमार बस्नेत	38	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
242	HOR	सुरेश भण्डारी	42	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
243	HOR	धर्म प्रसाद न्यौपाने	45	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
244	HOR	जीब नाथ निरौला	34	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
245	HOR	विनोद प्रसाद ढकाल	54	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
246	HOR	अमन लाल मोदी	37	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (माओवादी केन्द्र)(एकल चुनाव चिन्ह)	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
247	HOR	रवि रिजाल	50	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
248	HOR	श्याम बहादुर दर्जी	36	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
249	HOR	लक्ष्मण साहु	49	पुरुष	Nepali	लोकतान्त्रिक समाजवादी पार्टी, नेपाल	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
250	HOR	नविन कुमार विश्‍वास खवास	45	पुरुष	Nepali	हाम्रो नेपाली पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
251	HOR	धन बहादुर लिम्बु	31	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
252	HOR	गुल्टेन रिषिदेव	59	पुरुष	Nepali	संघीय लोकतान्त्रिक राष्ट्रिय मञ्च	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
253	HOR	अशोक पौडेल	50	पुरुष	Nepali	नेपाली कांग्रेस (बी.पी.)	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
254	HOR	नेत्र प्रसाद सिवाकोटी	48	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
255	HOR	राजेन्द्र कुमार खवास	53	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
256	HOR	कुवेत मिया	26	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
257	HOR	ज्ञानेन्द्र खत्री	47	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
258	HOR	पदम कार्की	27	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
259	HOR	महेश नेपाल	32	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
260	HOR	देव नारायण विश्‍वास	56	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
261	HOR	शिव कुमार मंडल (केवट)	47	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (माओवादी केन्द्र)(एकल चुनाव चिन्ह)	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
262	HOR	राज कुमार यादव	50	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
263	HOR	रेवत बहादुर थापा	76	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
264	HOR	परमेश्वर मुर्मु	42	पुरुष	Nepali	जनमत पार्टी	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
265	HOR	फिरोज कुमार साह	39	पुरुष	Nepali	हाम्रो नेपाली पार्टी	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
266	HOR	मंगल ऋषिदेव	39	पुरुष	Nepali	संघीय लोकतान्त्रिक राष्ट्रिय मञ्च	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
267	HOR	मजबुल रहमान मियाँ मुस्लिम	41	पुरुष	Nepali	नेपाल लोकतान्त्रिक पार्टी	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
268	HOR	प्रमोद कुमार मण्डल	37	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
269	HOR	रमेश कुमार यादव	33	पुरुष	Nepali	स्वतन्त्र	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
270	HOR	विधा भूषण प्रसाद	58	पुरुष	Nepali	स्वतन्त्र	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
271	HOR	मोहमद रेजा हुसैन	47	पुरुष	Nepali	स्वतन्त्र	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
272	HOR	सन्जु शर्मा वडइ	44	महिला	Nepali	स्वतन्त्र	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
273	HOR	गयानन्द मण्डल केवरत	69	पुरुष	Nepali	स्वतन्त्र	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
274	HOR	राम प्रसाद मुखिया	69	पुरुष	Nepali	स्वतन्त्र	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
275	HOR	योगेन्द्र मण्डल	51	पुरुष	Nepali	स्वतन्त्र	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
276	HOR	मनोज कुमार मण्डल	37	पुरुष	Nepali	स्वतन्त्र	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
277	HOR	लाल बाबु पंण्डित	63	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	6	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
278	HOR	डा शेखर कोइराला	72	पुरुष	Nepali	नेपाली काँग्रेस	6	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
279	HOR	गोपाल क्षेत्री	64	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	6	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
280	HOR	चिरञ्जिवि खतिवडा	33	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	6	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
281	HOR	बुद्धि राम माझि	42	पुरुष	Nepali	जनमत पार्टी	6	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
282	HOR	टेक वहादुर अधिकारी श्रेत्री	67	पुरुष	Nepali	हाम्रो नेपाली पार्टी	6	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
283	HOR	प्रशान्त ठाकुर	38	पुरुष	Nepali	जनता प्रगतिशिल पार्टी, नेपाल	6	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
284	HOR	बलराम खवास	46	पुरुष	Nepali	नागरिक उन्मुक्ति पार्टी	6	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
285	HOR	मोहन बहादुर राई	51	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	6	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
286	HOR	दुखाराम माझी	56	पुरुष	Nepali	संघीय लोकतान्त्रिक राष्ट्रिय मञ्च	6	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
287	HOR	नारायण पासवान	56	पुरुष	Nepali	बहुजन शक्ति पार्टी	6	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
288	HOR	यादव कुमार प्रधान	42	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	6	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
289	HOR	शुशिल खड्का	27	पुरुष	Nepali	स्वतन्त्र	6	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
290	HOR	सरोज नेपाल	31	पुरुष	Nepali	स्वतन्त्र	6	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
291	HOR	लक्ष्मी थेवे	45	पुरुष	Nepali	स्वतन्त्र	6	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
292	HOR	मुक्‍सामहाङ्ग सुब्‍बा	40	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (माओवादी केन्द्र)(एकल चुनाव चिन्ह)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
293	HOR	अशोक कुमार राई	65	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
294	HOR	अशोक कुमार राई	61	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
295	HOR	फत्त बहादुर खडका	58	पुरुष	Nepali	जनमत पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
296	HOR	देवी बहादुर राई	56	पुरुष	Nepali	किरात खम्बुवान साझा पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
297	HOR	प्रेम बहादुर श्रेष्ठ	39	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
298	HOR	सरस्वती सुब्बा	66	महिला	Nepali	संघीय लोकतान्त्रिक राष्ट्रिय मञ्च	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
299	HOR	मंगल सिंह लिम्बु	45	पुरुष	Nepali	जनसमाजवादी पार्टी नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
300	HOR	गोमा तामाङ	48	महिला	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
301	HOR	कृष्ण कुमार राई	56	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
302	HOR	तर्क बहादुर मगर	53	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
303	HOR	मनोज कुमार मेयाङ्गबो	58	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
304	HOR	जिवन कला राई	40	महिला	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
305	HOR	कुमार कार्की	34	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
306	HOR	वासु प्रसाद उपाध्याय (चालिसे)	60	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
308	HOR	संजय कुमार राई	41	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
309	HOR	मातृका प्रसाद भट्टराई	52	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
310	HOR	कुल बहादुर लिम्वु	64	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
311	HOR	करुणा राई	44	महिला	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
312	HOR	भीम प्रसाद आचार्य	63	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
313	HOR	सिताराम महतो	67	पुरुष	Nepali	नेपाली काँग्रेस	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
314	HOR	दिने‍श कुमार बस्‍नेत	50	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
315	HOR	मुमताज मियाँ	39	पुरुष	Nepali	लोकतान्त्रिक समाजवादी पार्टी, नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
316	HOR	रामानन्द मेहता	40	पुरुष	Nepali	जनमत पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
317	HOR	रोहित कुमार दुलाल	52	पुरुष	Nepali	मौलिक जरोकिलो पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
318	HOR	राजेश चौधरी	45	पुरुष	Nepali	हाम्रो नेपाली पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
319	HOR	दिपक राज चौधरी	51	पुरुष	Nepali	नागरिक उन्मुक्ति पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
320	HOR	रामेश्‍वर साहु हल्वाई	55	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
321	HOR	पूर्ण बहादुर गुरुङ्ग	71	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
322	HOR	नैन कुमार विश्वकर्मा	64	पुरुष	Nepali	संघीय लोकतान्त्रिक राष्ट्रिय मञ्च	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
323	HOR	नुनु राम चौधरी	47	पुरुष	Nepali	नेपाल लोकतान्त्रिक पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
324	HOR	शोभावती कुमारी चौधरी	46	महिला	Nepali	नेपाल कम्युनिष्ट पार्टी मार्क्सवादी (पुष्पलाल)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
325	HOR	विजय् कुमार बस्नेत	30	पुरुष	Nepali	विवेकशील साझा पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
326	HOR	गजेन्द्र वहादुर ढकाल	53	पुरुष	Nepali	जनसमाजवादी पार्टी नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
327	HOR	लाल बिक्रम थापा	36	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
328	HOR	ललन कुमार मेहता	37	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
329	HOR	शर्मानन्‍द खतिवडा	60	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
330	HOR	विदुर प्रसाद पौडेल	56	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
331	HOR	चेतनाथ पौडेल	40	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
332	HOR	वविता नुन्दी	35	महिला	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
333	HOR	मनोज कुमार मेहता	29	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
334	HOR	सुरेश कुमार मेहता	27	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
335	HOR	श्रवण कुमार मेहता	28	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
336	HOR	फरेन्द्र शाह	36	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
337	HOR	बाबुराम सुबेदी	41	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
338	HOR	प्रेम प्रसाद भट्टराई	69	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
339	HOR	भगवती चौधरी	51	महिला	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
340	HOR	विजय कुमार गच्‍छदार	68	पुरुष	Nepali	नेपाली काँग्रेस	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
341	HOR	कुलदीप चौधरी	49	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
342	HOR	देव नारायण यादव सिपलिया	52	पुरुष	Nepali	लोकतान्त्रिक समाजवादी पार्टी, नेपाल	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
343	HOR	रामेश्‍वर थापा	56	पुरुष	Nepali	मौलिक जरोकिलो पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
344	HOR	यज्ञ बहादुर कटुवाल	43	पुरुष	Nepali	हाम्रो नेपाली पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
345	HOR	राजो देवी रिषिदेव	45	महिला	Nepali	संघीय लोकतान्त्रिक राष्ट्रिय मञ्च	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
346	HOR	साहाउद्धीन मिया	41	पुरुष	Nepali	राष्ट्रिय जनमुक्ति पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
347	HOR	अम्वर वहादुर राउत	37	पुरुष	Nepali	नेपाली कांग्रेस (बी.पी.)	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
348	HOR	कुन्दन बहरदार	25	पुरुष	Nepali	पिछडावर्ग निषाद दलित जनजाती पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
349	HOR	कमल बाबु मैनाली	50	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
350	HOR	किशोर कुमार विश्‍वास	50	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
351	HOR	कासनी थरुनि	50	महिला	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
352	HOR	फागु यादव	63	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
353	HOR	गंगा कुमारी खरेल	47	महिला	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
354	HOR	मुकेश प्रसाद ढकाल	39	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
355	HOR	सज्जन ऋषिदेव	44	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
356	HOR	सुधा देवी उराँवनी	43	महिला	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
357	HOR	कुमारी उराव	54	महिला	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
358	HOR	स्मित कार्की	34	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
359	HOR	सुमन कुमारी चौधरी	35	महिला	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
360	HOR	सहिमुद्धिन मिया	71	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
361	HOR	जगदिश प्रसाद कुसियैत	62	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
362	HOR	ज्ञानेन्द्र बहादुर कार्की	65	पुरुष	Nepali	नेपाली काँग्रेस	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
363	HOR	विध्यानन्द यादव	35	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
364	HOR	अर्जुन प्रसाद भट्टराई	41	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
365	HOR	कुञ्जी लाल यादव	65	पुरुष	Nepali	लोकतान्त्रिक समाजवादी पार्टी, नेपाल	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
366	HOR	देवराम यादव	49	पुरुष	Nepali	जनमत पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
367	HOR	गुलाबचन मुसहर	46	पुरुष	Nepali	जनता प्रगतिशिल पार्टी, नेपाल	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
368	HOR	कुमार राई	39	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी माओवादी समाजवादी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
369	HOR	डम्बर बहादुर घिमिरे	58	पुरुष	Nepali	नेपालका लागि नेपाली पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
370	HOR	सत्य नारायण राम	52	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी नेपाल	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
371	HOR	मो.सदिक मियाँ	51	पुरुष	Nepali	संघीय लोकतान्त्रिक राष्ट्रिय मञ्च	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
372	HOR	गोपाल नेपाल	46	पुरुष	Nepali	एकीकृत शक्ति नेपाल	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
373	HOR	जिवन कुमार श्रेष्‍ठ	43	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
374	HOR	समिर मंसुरी	44	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
375	HOR	धिरज वर्मा	29	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
376	HOR	केशव उराँव	58	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
377	HOR	फेकन दास मोची	62	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
378	HOR	बिद्यानन्द प्रसाद साह	41	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
379	HOR	खालिद हुसेन हक	66	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
380	HOR	श्याम प्रसाद ढकाल	48	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
381	HOR	केशव कार्की	34	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
382	HOR	डील्ली बहादुर बिष्ट	52	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
383	HOR	मनोज कुमार मण्डल	42	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
384	HOR	बालेश्‍वर यादव	32	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
385	HOR	अब्दुलजब्बार अंसारी	42	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	11
386	HOR	मानबीर राई	52	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
387	HOR	बल बहादुर के.सी	69	पुरुष	Nepali	नेपाली काँग्रेस	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
388	HOR	लाक्पा शेर्पा	40	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
389	HOR	ज्ञानेन्द्र बहादुर बस्नेत	59	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
390	HOR	तारानाथ कटेल	55	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
391	HOR	विष्‍णु प्रसाद वास्तोला	69	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (मार्क्सवादी लेनिनवादी)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
392	HOR	सौविर राई (थुलुङ्ग)	40	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
393	HOR	लामु शेर्पा	26	महिला	Nepali	संघीय लोकतान्त्रिक राष्ट्रिय मञ्च	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
394	HOR	विशाल भट्टराई	53	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
395	HOR	राम कुमार राई	54	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (माओवादी केन्द्र)(एकल चुनाव चिन्ह)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
396	HOR	कृष्ण कुमार राई	67	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
397	HOR	सर्जु श्रेष्ठ	30	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
398	HOR	भोज राज बस्नेत	57	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
399	HOR	दिपक मगर	31	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
400	HOR	चन्द्रमणि राई	36	पुरुष	Nepali	आमूल परिवर्तन मसिहा पार्टी नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
401	HOR	जयन्द्र कुमार राई	51	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	\N
402	HOR	यज्ञ राज सुनुवार	50	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	7
403	HOR	राम हरि खतिवडा	52	पुरुष	Nepali	नेपाली काँग्रेस	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	7
404	HOR	जुद्ध बहादुर राई	50	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	7
405	HOR	डिक प्रसाद बास्तोला	50	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	7
406	HOR	कुमार तामाङ्ग	48	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	7
407	HOR	विर्ज वहादुर थापा मगर	36	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	7
408	HOR	ङिमा लमु शेर्पा	52	महिला	Nepali	संघीय लोकतान्त्रिक राष्ट्रिय मञ्च	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	7
409	HOR	शोभा कार्की	39	महिला	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	7
410	HOR	मन्जु कुमारी चौधरी	48	महिला	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	14
411	HOR	डा. नारायण खड्का	73	पुरुष	Nepali	नेपाली काँग्रेस	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	14
412	HOR	गोपाल राई	44	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	14
413	HOR	धुर्व कुमार राय माझी	53	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	14
414	HOR	विष्‍णु वहादुर खत्री	44	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	14
415	HOR	खुसी लाल ठाकुर	66	पुरुष	Nepali	लोकतान्त्रिक समाजवादी पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	14
416	HOR	मुकेश सहनि	35	पुरुष	Nepali	जनता प्रगतिशिल पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	14
417	HOR	कृत नारायण चौधरी	42	पुरुष	Nepali	नागरिक उन्मुक्ति पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	14
418	HOR	ललकु चौधरी	49	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	14
419	HOR	राम प्रसाद चौलागाई	55	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (मार्क्सवादी लेनिनवादी)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	14
420	HOR	केशर बहादुर मगर	35	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	14
421	HOR	कम्पस बहादुर राई	45	पुरुष	Nepali	संघीय लोकतान्त्रिक राष्ट्रिय मञ्च	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	14
422	HOR	गोकर्ण राई	60	पुरुष	Nepali	राष्ट्रिय जनमुक्ति पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	14
423	HOR	हरी बहादुर बुढाथोकी	45	पुरुष	Nepali	सचेत नेपाली पार्टी(एकल चुनाव चिन्ह)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	14
424	HOR	उध्दब अधिकारी	39	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	14
425	HOR	राम श्रेष्‍ठ चौधरी	47	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	14
426	HOR	अम्वर बहादुर रायामाझी	53	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	14
427	HOR	सिद्धान्त राई	43	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	14
428	HOR	वन्सिधर न्यौपाने	47	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	14
429	HOR	पुर्ण बहादुर बुढाथोकी	37	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	14
430	HOR	जगन्नाथ खतिवडा	60	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एकिकृत समाजबादी)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	14
431	HOR	लोकेन्द्र बहादुर कार्की	46	पुरुष	Nepali	हाम्रो नेपाली पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	14
432	HOR	भाष्कर राई	37	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	14
433	HOR	केशव बहादुर पाण्डे	68	पुरुष	Nepali	नेपाली कांग्रेस (बी.पी.)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	14
434	HOR	विन्दा कुमारी कटुवाल	51	महिला	Nepali	जनजागरण पार्टी नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	14
435	HOR	अनिल कुमार श्रेष	50	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	14
436	HOR	राम कुमार राई	50	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	14
437	HOR	राम मणि पौडेल	53	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	1	14
438	HOR	रामदेव साह(तेली)	63	पुरुष	Nepali	नेपाली काँग्रेस	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
439	HOR	नवल किसोर साह सुडी	73	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
440	HOR	विष्णु देव यादव	53	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
441	HOR	हरी शंकर पंडित कुम्हाल	57	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
442	HOR	जय कान्त राउत	49	पुरुष	Nepali	जनमत पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
443	HOR	टिकालक्ष्‍मी चौधरी	38	महिला	Nepali	नागरिक उन्मुक्ति पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
444	HOR	नागेशर प्रसाद साह	41	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
625	HOR	जय नारायण साह	56	पुरुष	Nepali	जनमत पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
445	HOR	पदम वहादुर राना	66	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
446	HOR	श्रवण कुमार चौधरी थारु	49	पुरुष	Nepali	नेपाल लोकतान्त्रिक पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
447	HOR	निरंजन प्रसाद कुशवाहा	25	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
448	HOR	रोहित कुमार पोखरेल	62	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
449	HOR	दिलीप कुमार चौधरी	59	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
450	HOR	फजिल मंसुरी	50	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
451	HOR	विद्यानन्द लेखी	51	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
452	HOR	सर्वेश कुमार नायक	28	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
453	HOR	नारायण ठाकुर	59	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
454	HOR	प्रकाश कुमार नाहाटा	41	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
455	HOR	कविन्द्र यादब	41	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
456	HOR	चन्द्रनारायण यादव	55	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
457	HOR	अशोक कुमार मंडल	45	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
458	HOR	उपेन्द्र यादव	61	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
459	HOR	कैला मंसुरी (मियाँ)	53	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
460	HOR	देव नारायण यादव	55	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
461	HOR	जय प्रकाश ठाकुर	66	पुरुष	Nepali	लोकतान्त्रिक समाजवादी पार्टी, नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
462	HOR	चन्द्र कान्त राउत	45	पुरुष	Nepali	जनमत पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
463	HOR	डम्वर नारायण साह तेली	64	पुरुष	Nepali	हाम्रो नेपाली पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
464	HOR	हजरत अलि	58	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
465	HOR	चिरंजिबी लाल देव	73	पुरुष	Nepali	नेपाली कांग्रेस (बी.पी.)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
466	HOR	सु्मित्रा मंडल	43	महिला	Nepali	पिछडावर्ग निषाद दलित जनजाती पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
467	HOR	प्रमिला देवी मण्डल	52	महिला	Nepali	नेपाल संघीय समाजवादी पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
468	HOR	चन्द्र कुमारी देव	64	महिला	Nepali	नेपाली जनता दल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
469	HOR	बरुण कुमार झा	36	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
470	HOR	विरेन्द्र कुमार मिश्र	47	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
471	HOR	महेन्द्र प्रसाद देव	64	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
472	HOR	चित्तनारायण यादव	64	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
473	HOR	विनोद कुमार यादव	43	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
474	HOR	ताराकान्त चौधरी	57	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
475	HOR	दिनेश कुमार यादव	61	पुरुष	Nepali	नेपाली काँग्रेस	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
476	HOR	गंगाराम ठाकुर	62	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
477	HOR	मखबुल मियाँ	53	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
478	HOR	लक्ष्मीकान्त मंडल	54	पुरुष	Nepali	लोकतान्त्रिक समाजवादी पार्टी, नेपाल	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
479	HOR	अनिश अंसारी	68	पुरुष	Nepali	जनमत पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
480	HOR	नवीन मण्डल	40	पुरुष	Nepali	हाम्रो नेपाली पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
481	HOR	शिवेश्‍वर रजक	62	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी नेपाल	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
482	HOR	अचमित लाल चौधरी	66	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
483	HOR	सीताराम खंग	66	पुरुष	Nepali	नेपाल संघीय समाजवादी पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
484	HOR	रामवावु रजक	39	पुरुष	Nepali	नेपाली जनता दल	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
485	HOR	प्रमोद कुमार साह	40	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
486	HOR	महेन्द्र प्रसाद साह	60	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
487	HOR	दिपेन्द्र कुमार साह	42	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
488	HOR	सिता राम मंडल	55	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
489	HOR	श्रीकान्त राउत	39	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
490	HOR	सुरेश कुमार यादव	42	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
491	HOR	राम चन्द्र साह	61	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
492	HOR	तेजु लाल चौधरी	60	पुरुष	Nepali	नेपाली काँग्रेस	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
493	HOR	वालकिसोर यादव	48	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
494	HOR	मकुन चौधरी	46	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
495	HOR	सुकदेव प्रसाद साह	72	पुरुष	Nepali	जनमत पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
496	HOR	देमन मियाँ	52	पुरुष	Nepali	नागरिक उन्मुक्ति पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
497	HOR	कपिल देव यादव	50	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी नेपाल	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
498	HOR	बिश्‍वेन्द्र पासवान	61	पुरुष	Nepali	बहुजन शक्ति पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
499	HOR	संजोग चौधरी	37	पुरुष	Nepali	नेपाल सद्भावना पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
500	HOR	देवानन्‍द   चौधरी	55	पुरुष	Nepali	नेपाल आमा पार्टी(एकल चुनाव चिन्ह)	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
501	HOR	मो. इरफान आलम	30	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
502	HOR	सुर‍ेश कुमार चौधरी थारु	28	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
503	HOR	मो. कासीम मिया	60	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
504	HOR	जियाउल रहमान	57	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
505	HOR	छेदी लाल पासवान	56	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
506	HOR	शंकर लाल चौधरी	73	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
507	HOR	माधुरी कुमारी साह	56	महिला	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	21
508	HOR	राम शंकर यादव	61	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
509	HOR	पदम नारायण चौधरी	74	पुरुष	Nepali	नेपाली काँग्रेस	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
510	HOR	दिनेश कुमार महतो	32	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
511	HOR	सिरीया पासमान	53	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
512	HOR	युगल किशोर साह	42	पुरुष	Nepali	जनमत पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
513	HOR	सुरेश कुमार कामैत	28	पुरुष	Nepali	मौलिक जरोकिलो पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
514	HOR	ललीता कुमारी साह	34	महिला	Nepali	जनता प्रगतिशिल पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
515	HOR	रीता देवी साह	43	महिला	Nepali	नेपालका लागि नेपाली पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
516	HOR	हरि राम दास	75	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
517	HOR	मनोज पासमान	45	पुरुष	Nepali	बहुजन एकता पार्टी नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
518	HOR	जनक साह	54	पुरुष	Nepali	संघीय लोकतान्त्रिक राष्ट्रिय मञ्च	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
519	HOR	जीवछ प्रसाद यादव	52	पुरुष	Nepali	नेपाल सद्भावना पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
520	HOR	राम कुमार यादव	41	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
521	HOR	ओम सिंह	26	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
522	HOR	राम ध्यान महतो	40	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
523	HOR	गोविन्द कुमार चौधरी	43	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
524	HOR	बिद्यापती झा	41	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
525	HOR	लव कुमार प्रधान	34	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
526	HOR	सरिता गिरी	60	महिला	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
527	HOR	अशोक कुमार थपलिया	58	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
528	HOR	राम कुमार साह	50	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
529	HOR	राजेन्‍द्र प्रसाद यादव	55	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
530	HOR	पुस्पेन्द्र कुमार यादव	30	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
531	HOR	चित्रलेखा यादब	57	महिला	Nepali	नेपाली काँग्रेस	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
532	HOR	राज किशोर यादव	49	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
533	HOR	मुरलि मिझार	67	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
534	HOR	राज कुमार पासमान	50	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
535	HOR	बिनोद कुमार यादव	53	पुरुष	Nepali	जनमत पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
536	HOR	शिव शंकर यादव	27	पुरुष	Nepali	हाम्रो नेपाली पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
537	HOR	रास लाल सिंह	50	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
538	HOR	शिला देवी राम	44	महिला	Nepali	संघीय लोकतान्त्रिक राष्ट्रिय मञ्च	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
539	HOR	राजेन्‍द्र पाख्रीन	46	पुरुष	Nepali	राष्ट्रिय जनमुक्ति पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
540	HOR	शिब राम यादव	46	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
541	HOR	कारी राम यादव	49	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
542	HOR	देव कुमार यादव	50	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
543	HOR	राम रिझन यादब	62	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
544	HOR	हरि नारायण नेपाल यादव	38	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
545	HOR	शिव राम यादव	36	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
546	HOR	परमेश्वर कामती	40	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
547	HOR	दिलीप ठाकुर	34	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
548	HOR	सुरेश कुमार कार्की	50	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
549	HOR	दिपक कुमार यादव	29	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
550	HOR	लक्ष्‍मण कुमार दास	30	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
551	HOR	राम प्रकाश महतो	38	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
552	HOR	शिव कुमार यादव	39	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
553	HOR	संतोष कुमार यादव	28	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
554	HOR	आनन्द कुमार यादव	49	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
555	HOR	लिलानाथ श्रेष्ठ	65	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
556	HOR	विश्‍वनाथ साह	69	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (माओवादी केन्द्र)(एकल चुनाव चिन्ह)	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
557	HOR	गोवर्धन दास तत्मा	69	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
558	HOR	दिनेश  कुमार  यादव	33	पुरुष	Nepali	जनमत पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
559	HOR	राज कुमार मुखिया	44	पुरुष	Nepali	पिछडावर्ग निषाद दलित जनजाती पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
560	HOR	सरोज कुमार यादव	33	पुरुष	Nepali	जनसमाजवादी पार्टी नेपाल	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
561	HOR	दिपक कुमार साह	39	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
562	HOR	प्रदिप कुमार श्रेष्ठ	40	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
563	HOR	सीता पौखरेल	47	महिला	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
564	HOR	नारायण ठाकुर	31	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
565	HOR	राम  पुकार  यादव	35	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
566	HOR	रबिन्द्र कुमार यादव	40	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
567	HOR	बौवे लाल यादव	67	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
568	HOR	दिप कुमार लामा	47	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
569	HOR	ओम प्रकाश श्रेष्ठ	34	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
570	HOR	श्याम सुन्दर यादव	39	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
571	HOR	सुमित श्रेष्ठ	27	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
572	HOR	निलेश कुमार श्रेष्‍ठ	31	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
573	HOR	विक्रम कुमार साह	45	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
574	HOR	सुरेन्द्र कुमार महतो	36	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
575	HOR	राकेश कुमार यादव	31	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
576	HOR	बिरेन्द्र प्रसाद महतो	53	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
577	HOR	नगीना कुमार झा	36	महिला	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
578	HOR	रामेश्वर साह	62	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
579	HOR	धर्मनाथ प्रसाद साह	62	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एकिकृत समाजबादी)	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
580	HOR	वीरेन्द्र प्रसाद साह	53	पुरुष	Nepali	जनमत पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
581	HOR	प्रमोद चौधरी	50	पुरुष	Nepali	नेपालका लागि नेपाली पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
582	HOR	विजय यादव	44	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी नेपाल	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
583	HOR	बिजय कुमार पजियार	44	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (मार्क्सवादी लेनिनवादी)	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
584	HOR	तारा देवी भण्डारी	41	महिला	Nepali	नेपाल आमा पार्टी(एकल चुनाव चिन्ह)	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
585	HOR	विमल कुमार तिवारी	45	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
586	HOR	राजेश कुमार यादब	33	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
587	HOR	अन्जनी राई	48	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
588	HOR	दिपेन्‍द्र राउत	34	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
589	HOR	जागेश्‍वर यादव	57	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
590	HOR	सुरेन्‍द्र कुमार ठाकुर	27	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
591	HOR	कासिन्द्र यादव	42	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
592	HOR	सन्त कुमार शर्मा	36	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
593	HOR	फुलगेन नायक	49	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
594	HOR	दिपक कुमार श्रेष्ठ	39	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	19
595	HOR	मातृका प्रसाद यादव	64	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (माओवादी केन्द्र)(एकल चुनाव चिन्ह)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
596	HOR	दीपक कार्की	58	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
597	HOR	मनोज मल्ल ठकुरी	53	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
598	HOR	किशोरी साह कमल	52	पुरुष	Nepali	जनमत पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
599	HOR	लक्ष्मण महतो सुडी	61	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
600	HOR	राजदेव महतो	62	पुरुष	Nepali	नेपाल सद्भावना पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
601	HOR	केशर मुखिया	37	पुरुष	Nepali	सामाजिक एकता पार्टी(एकल चुनाव चिन्ह)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
602	HOR	धर्मेन्द्र कुमार राय	49	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
603	HOR	दामोदर चौहान	49	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
604	HOR	अजय कुमार ठाकुर	43	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
605	HOR	लक्ष्‍मेसर साह	36	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
606	HOR	जनार्दन मंडल	51	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
607	HOR	जय नारायण यादव	50	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
608	HOR	अशोक कुमार यादव	48	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
609	HOR	युगेश्वर यादव	55	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
610	HOR	भुपेन्द्र यादव	39	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
611	HOR	महेश कुमार यादव	30	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
612	HOR	अशोक गोहितमान	39	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
613	HOR	साधु यादव	64	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
614	HOR	सुर्य नारायण जोशि	37	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
615	HOR	स‌ंजित कुमार साह	35	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
616	HOR	महेश लाल यादव	38	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
617	HOR	विजय कुमार यादब	53	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
618	HOR	धिरज प्रसाद न्यौपाने	35	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
619	HOR	मोहमद तैयब सेख	41	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
620	HOR	उमाशंकर अरगरिया	45	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
621	HOR	राम कृष्ण यादव	60	पुरुष	Nepali	नेपाली काँग्रेस	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
622	HOR	आनन्द यादव	73	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
623	HOR	राज कुमार अधिकारी	54	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
624	HOR	राम चन्द्र झा	68	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एकिकृत समाजबादी)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
626	HOR	रुप नारायण मंडल, केवट	65	पुरुष	Nepali	जनता प्रगतिशिल पार्टी, नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
627	HOR	चनसेखर कुमार यादव	26	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
628	HOR	प्रदिप कुमार यादब	49	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
629	HOR	बद्री प्रसाद फरकार यादव	25	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
630	HOR	न्यास यादव	33	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
631	HOR	शिवा नन्द पाण्डे	64	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
632	HOR	राजेश कुमार अमात	37	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
633	HOR	शैलेन्द्र कुमार सिंह	54	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
634	HOR	राम एकवाल यादव	57	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
635	HOR	घुरन यादव	49	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
636	HOR	जुली कुमारी महतो (महासेठ)	46	महिला	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
637	HOR	राम पदारथ मंडल	53	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
638	HOR	राम हृदय साह तेली	47	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
639	HOR	अनिल कुमार झा	55	पुरुष	Nepali	लोकतान्त्रिक समाजवादी पार्टी, नेपाल	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
640	HOR	शम्भु नाथ साह	44	पुरुष	Nepali	जनमत पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
677	HOR	राम अचल यादव	25	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
641	HOR	हुसैन कवारी	51	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी नेपाल	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
642	HOR	लक्ष्मी मण्डल खत्वे	64	पुरुष	Nepali	बहुजन एकता पार्टी नेपाल	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
643	HOR	पुनम चोधरी	56	महिला	Nepali	नेपाल जनता पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
644	HOR	प्रविणा कुमारी ठाकुर	33	महिला	Nepali	इतिहासिक प्रजातान्त्रिक जनता पार्टी नेपाल	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
645	HOR	रंजित पंजियार	36	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
646	HOR	पुजा साह	25	महिला	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
647	HOR	सत्य नारायण शाह	68	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
648	HOR	बैदेही रमण ठाकुर	55	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
649	HOR	त्रिदेव कुमार मिश्र	28	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
650	HOR	मो. जासिम नदाफ	34	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
651	HOR	मात्रिका प्रसाद दास	25	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
652	HOR	श्याम किशोर साह	53	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
653	HOR	अरबिन्द कुमार पासवान	47	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
654	HOR	अनिल कुमार यादव	41	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
655	HOR	अजय कुमार यादव	35	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
656	HOR	राज कुमार साह	35	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
657	HOR	उमेश साह	56	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
658	HOR	मिलन कुमारी शाह	54	महिला	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
659	HOR	चन्द्र शेषर साह	46	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
660	HOR	शिलाकान्त झा	47	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
661	HOR	उमेश चौधरी	50	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
662	HOR	ज्योति कुमारी साह	25	महिला	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
663	HOR	जीवन साह तेली	46	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
664	HOR	सुनिल कुमार कर्ण	46	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
665	HOR	अमरेन्द्र कण्‍ठ	40	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
666	HOR	कृष्णा यादव	26	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
667	HOR	रघुबीर महासेठ	61	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
668	HOR	महेन्द्र यादव	60	पुरुष	Nepali	नेपाली काँग्रेस	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
669	HOR	महाजन यादव	66	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
670	HOR	अनिरुद्ध यादव	59	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
671	HOR	राम चन्द्र यादव	63	पुरुष	Nepali	जनता प्रगतिशिल पार्टी, नेपाल	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
672	HOR	कृष्ण चन्द्र प्रसाद साह	60	पुरुष	Nepali	नेपाल लोकतान्त्रिक पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
673	HOR	राम दुलार महतो	57	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
674	HOR	संजय कुमार यादव	43	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
675	HOR	राजकुमार यादव	46	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
676	HOR	महेश कुमार यादव	27	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
678	HOR	राम कृष्ण यादव	46	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
679	HOR	दिपेश कुमार यादव	25	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
680	HOR	श्याम किसोर यादव	52	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
681	HOR	अनिल कुमार चौधरी	26	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
682	HOR	विजय कुमार यादव	46	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
683	HOR	श्रवण दास तत्मा	59	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
684	HOR	देबेन्द्र कुमार पजियार	55	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
685	HOR	विजय कुमार साह सुडी	43	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
686	HOR	कलम देव यादव	48	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
687	HOR	हरि किशोर यादव	34	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
688	HOR	संजय कुमार यादव	35	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
689	HOR	व्रहमदेव महतो	36	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
690	HOR	कृष्ण कुमार महतो	27	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
691	HOR	प्रशुराम कुमार यादब	29	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
692	HOR	रामगुण यादव	25	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
693	HOR	अरुण कुमार साह	39	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
694	HOR	नवल यादव	38	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
695	HOR	राजेश कुमार यादव	33	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	20
696	HOR	लझ्मी महतो काेइरी	58	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
697	HOR	गिरिराज  मणी  पोखरेल	65	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (माओवादी केन्द्र)(एकल चुनाव चिन्ह)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
698	HOR	पुजा घिमिरे	29	महिला	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
699	HOR	राज किशोर साह	40	पुरुष	Nepali	जनमत पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
700	HOR	स‌जिव साह सोनार	34	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
701	HOR	गनेश वहादुर आले	51	पुरुष	Nepali	राष्ट्रिय जनमुक्ति पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
702	HOR	मनु प्रसाद अधिकारी	66	पुरुष	Nepali	नेपाली कांग्रेस (बी.पी.)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
703	HOR	खेम कुमारी भुर्तेल	39	महिला	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
704	HOR	राम प्रगास महतो	35	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
705	HOR	केशव कुमार पोखरेल	48	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
706	HOR	शिव बहादुर खड्रका	60	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
707	HOR	पोषण बहादुर थापा	44	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
708	HOR	गोपाल बहादुर कार्की	53	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
709	HOR	मनोज कुमार महतो	35	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
710	HOR	जय कुमार साह	30	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
711	HOR	राम परिक्षण यादव	63	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
712	HOR	शरत सिंह भण्डारी	68	पुरुष	Nepali	लोकतान्त्रिक समाजवादी पार्टी, नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
713	HOR	उमेश कुमार यादव	54	पुरुष	Nepali	जनमत पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
714	HOR	शिवचन्दर यादव	56	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
715	HOR	विजय कुमार सिंह	70	पुरुष	Nepali	तराइ-मधेश लोकतान्त्रिक पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
716	HOR	प्रदिप कुमार यादव	43	पुरुष	Nepali	नेपाल संघीय समाजवादी पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
717	HOR	विश्‍वनाथ पासमान	46	पुरुष	Nepali	जनजागरण पार्टी नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
718	HOR	पवन कुमार झा	38	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
719	HOR	अजय कुमार महतो	31	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
720	HOR	राम पुकार साह	54	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
721	HOR	राम विजय भंडारी	38	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
722	HOR	तारजन कुमार बैठा	36	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
723	HOR	राजेश प्रसाद साह	39	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
724	HOR	अजित कुमार साह	37	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
725	HOR	जवाहर कान्त साह	59	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
726	HOR	सत्‍य नारायन साह	36	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
727	HOR	मुरारी लाल चौधरी	28	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
728	HOR	हरि नारायण यादव	60	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
729	HOR	महन्थ ठाकुर	80	पुरुष	Nepali	लोकतान्त्रिक समाजवादी पार्टी, नेपाल	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
730	HOR	मृगेन्द्र यादव	35	पुरुष	Nepali	जनमत पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
731	HOR	गुलाब कुमारी देवी मण्डल	42	महिला	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी नेपाल	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
732	HOR	जिवछी देवी	49	महिला	Nepali	नेश्नलिष्ट पिपल्स पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
733	HOR	राम ईकवाल मण्‍डल	48	पुरुष	Nepali	राष्ट्रिय जनमुक्ति पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
734	HOR	बृषेश चन्द्र लाल	67	पुरुष	Nepali	तराइ-मधेश लोकतान्त्रिक पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
772	HOR	जय नारायण महतो	42	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
735	HOR	एल्सा झा	42	महिला	Nepali	एकीकृत शक्ति नेपाल	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
736	HOR	इलियास अंसारी	68	पुरुष	Nepali	नेपाल संघीय समाजवादी पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
737	HOR	ओम प्रकाश यादव	35	पुरुष	Nepali	नेपाल सद्भावना पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
738	HOR	सरविन्द्र यादव	29	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
739	HOR	इन्‍द्रजित कुमार यादव	30	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
740	HOR	विनय कुमार यादव	45	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
741	HOR	राम बाबु सिंह	59	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
742	HOR	राम आधार कापर	52	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
743	HOR	शरत चन्द्र मिश्र	55	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
744	HOR	मंगल देव ठाकुर	58	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
745	HOR	कुलभुषण शेखर शर्मा	39	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
746	HOR	प्रदीप कुमार यादव	39	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
747	HOR	युसुफ साफी	51	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
1538	HOR	रमेश गैरे	40	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
748	HOR	शंकर प्रसाद कापर	49	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
749	HOR	महेन्‍द्र कुमार राय	63	पुरुष	Nepali	नेपाली काँग्रेस	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
750	HOR	सुरेन्‍द्र कुमार यादव	51	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
751	HOR	मनोज कुमार साह	47	पुरुष	Nepali	जनमत पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
752	HOR	सुबराती मंसुर	56	पुरुष	Nepali	हाम्रो नेपाली पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
753	HOR	शिवजी यादव	65	पुरुष	Nepali	जनता प्रगतिशिल पार्टी, नेपाल	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
754	HOR	महेन्‍द्र मण्‍डल	43	पुरुष	Nepali	नेपालका लागि नेपाली पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
755	HOR	दिलिप राम	26	पुरुष	Nepali	बहुजन एकता पार्टी नेपाल	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
756	HOR	राम दुलार मंडल	45	पुरुष	Nepali	राष्ट्रिय जनमुक्ति पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
757	HOR	विजय कुमार साह	38	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
758	HOR	विजयेन्‍द्र कुमार यादव	45	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
759	HOR	कामेन्‍द्र कुमार कमल	69	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
760	HOR	रामजी राय	52	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
761	HOR	कृष्‍णदेव कुमार यादव	59	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
762	HOR	सुधिर कुमार यादव	39	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	22
763	HOR	प्रमोद साह	43	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
764	HOR	राजेन्द्र प्रसाद मैनाली	56	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
765	HOR	रमाकान्त कापर	51	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
766	HOR	राम प्रकाश चौधरी	58	पुरुष	Nepali	लोकतान्त्रिक समाजवादी पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
767	HOR	राम विश्‍वास राय	36	पुरुष	Nepali	जनमत पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
768	HOR	बल राम बस्नेत	44	पुरुष	Nepali	जनसमाजवादी पार्टी नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
769	HOR	राम दुलार महतो	30	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
770	HOR	आकाश वती दनुवार	65	महिला	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
771	HOR	धिरेन्द्र यादव	27	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
773	HOR	संजय कुमार मंडल	41	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
774	HOR	सुरेश राज शर्मा	49	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
775	HOR	जय नारायन महतो	60	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
776	HOR	दिपेश कुमार कार्कि	35	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
777	HOR	ध्वज मान मुक्तान	52	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
778	HOR	दामोदर चौधरी	42	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
779	HOR	मनोज कुमार चौधरी	42	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
780	HOR	मान बहादुर खड्का	51	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
781	HOR	बैकुण्ठ सापकोटा	48	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
782	HOR	राज नारायण साह	58	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
783	HOR	महिन्द्र राय यादव	85	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (माओवादी केन्द्र)(एकल चुनाव चिन्ह)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
784	HOR	विकेश महतो	35	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
785	HOR	राजेन्द्र महतो	63	पुरुष	Nepali	लोकतान्त्रिक समाजवादी पार्टी, नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
786	HOR	नरेश प्रसाद कुशवाहा	42	पुरुष	Nepali	जनमत पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
787	HOR	वीर वंश वैठा	58	पुरुष	Nepali	हाम्रो नेपाली पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
788	HOR	मोहम्मद मनसरीफ अंसारी	51	पुरुष	Nepali	बहुजन एकता पार्टी नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
789	HOR	मोस्तकिम अंसारी	62	पुरुष	Nepali	नेपाल संघीय समाजवादी पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
790	HOR	जय करण महतो	31	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
791	HOR	राम नाथ साह	42	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
792	HOR	श्रवण साह	27	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
793	HOR	सतिश कुमार चौधरी	28	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
794	HOR	कामिल मियाँ मुकेरी	51	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
795	HOR	शुसिला  कुमारी	33	महिला	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
796	HOR	राज किशोर राय यादव	54	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
797	HOR	राजनारायण राय यादव	51	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
798	HOR	मनोज कुमार साह	31	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
799	HOR	हरि प्रसाद उप्रेती	55	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
800	HOR	नरेन्द्र साह कलवार	50	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (माओवादी केन्द्र)(एकल चुनाव चिन्ह)	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
801	HOR	त्रिभुवन कुमार सिंह	49	पुरुष	Nepali	जनमत पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
802	HOR	भवानी घिमिरे	44	महिला	Nepali	हाम्रो नेपाली पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
803	HOR	राज कुमार पासवान	43	पुरुष	Nepali	बहुजन एकता पार्टी नेपाल	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
804	HOR	ईन्द्र मान वाइवा	53	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
805	HOR	पञ्च बहादुर सिङ्गतान	40	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
806	HOR	ओम प्रसाद मैनाली	42	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
807	HOR	राम विहारी महतो	51	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
808	HOR	अभिषेक  प्रसाद  साह	26	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
809	HOR	कृष्ण राय यादव	25	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
810	HOR	उत्तर कुमार मैनाली	48	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
811	HOR	श्‍याम बावु यादव	33	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
812	HOR	नागेन्द्र कुमार	69	पुरुष	Nepali	नेपाली काँग्रेस	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
813	HOR	राकेश कुमार मिश्र	48	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
814	HOR	महेश महतो	42	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
815	HOR	राम बावु राय	66	पुरुष	Nepali	जनमत पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
816	HOR	अजित कुमार साह	28	पुरुष	Nepali	हाम्रो नेपाली पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
817	HOR	उपेन्द्र राय	54	पुरुष	Nepali	जनता प्रगतिशिल पार्टी, नेपाल	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
818	HOR	राजा राम पासवान	47	पुरुष	Nepali	बहुजन एकता पार्टी नेपाल	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
819	HOR	दिनेश  राय	27	पुरुष	Nepali	गान्धीवादी पार्टी नेपाल	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
820	HOR	राजिनन्द प्रसाद चौधरी	60	पुरुष	Nepali	नेपाल जनता पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
821	HOR	रामाज्ञा यादव	57	पुरुष	Nepali	नेपाल संघीय समाजवादी पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
822	HOR	धिरज ठाकुर	29	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
823	HOR	मधुमाला कुमारी यादव	26	महिला	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
824	HOR	सोशिल कुमार सिंह	40	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
825	HOR	गनेश प्रसाद सिंह	66	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
826	HOR	अमरेश कुमार सिह	52	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
827	HOR	राहुल कुमार सिंह	29	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
828	HOR	अरविन्द कुमार ठाकुर	44	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
829	HOR	बिजेन्द्र कुमार कुशवाहा	39	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
830	HOR	राजेश कुमार मिश्र	37	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
831	HOR	हरि श्याम राय	39	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	18
832	HOR	अजय कुमार गुप्‍ता	48	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
833	HOR	बैद्यनाथ प्रसाद चौधरी	48	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
834	HOR	माधव कुमार नेपाल	69	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एकिकृत समाजबादी)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
835	HOR	राजेन्द्र प्रसाद साह	62	पुरुष	Nepali	जनमत पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
836	HOR	सरोज कुमारी	42	महिला	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
837	HOR	रंजित कुमार  पटेल	28	पुरुष	Nepali	नेपाल सुशासन पार्टी(एकल चुनाव चिन्ह)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
838	HOR	सुबोध चन्द्र शाह	31	पुरुष	Nepali	नेपाली जनता दल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
839	HOR	मिस्टर सुर्यदेव प्र कोईराला	29	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
840	HOR	अवधेश कुमार ठाकुर	64	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
841	HOR	राहुल कुमार मिश्र	25	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
842	HOR	अनिल कुमार लाल दास	50	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
843	HOR	राम अधार महतो कोईरी	43	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
844	HOR	मोहम्मद जियाउल हक	30	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
845	HOR	चन्दन कुमार जयसवाल	38	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
846	HOR	रेवन्त झा	52	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
847	HOR	रामबलि कुमार यादव	37	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
848	HOR	कोशिला देवी	46	महिला	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
849	HOR	मो. फिरदोस अ‍ालम	35	पुरुष	Nepali	नेपाली काँग्रेस	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
850	HOR	शैलेन्द्र शाह	51	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
851	HOR	दिनेश प्रसाद शाह तेली	50	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
852	HOR	रामयस झा	67	पुरुष	Nepali	जनमत पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
853	HOR	महिन्‍द्र साह तेली	78	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
854	HOR	नन्दकिशोर प्रसाद यादव	29	पुरुष	Nepali	गान्धीवादी पार्टी नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
855	HOR	पनी लाल साह	44	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
856	HOR	शेख यार महमद	68	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
857	HOR	किरण कुमार साह	44	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
858	HOR	शेख अब्दुल वोहिद	63	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
859	HOR	शेख सोवएल	41	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
860	HOR	अरुण कुमार साह	26	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
861	HOR	मो.रईस आलम	57	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
862	HOR	रविन्‍द्र पटेल	44	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (माओवादी केन्द्र)(एकल चुनाव चिन्ह)	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
863	HOR	सिकिन्द्र राय यादव	51	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
864	HOR	रफिक दर्जी	45	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
865	HOR	रामेश्‍वर प्रसाद यादव	63	पुरुष	Nepali	जनमत पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
866	HOR	नागेन्द्र चौधरी	45	पुरुष	Nepali	नागरिक उन्मुक्ति पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
867	HOR	शेख अरसद	28	पुरुष	Nepali	नेपाल सद्भावना पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
868	HOR	नवीन प्रसाद चौरसिया	32	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
869	HOR	राजेश कुमार पासवान	27	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
870	HOR	उमेश कुमार दास तत्मा	30	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
871	HOR	अ‍ोमप्रकाश -	49	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
872	HOR	राज कुमार शर्मा	26	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
873	HOR	विरेन्द्र  साह  कलवार	41	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
874	HOR	गनिलाल प्रसाद यादव	32	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
875	HOR	महेन्द्र प्रसाद चौधरी	70	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
876	HOR	योगेन्द्र साह	50	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
877	HOR	सुरेश कुमार यादव	25	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
878	HOR	नागेन्द्र प्रसाद साह	50	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
879	HOR	प्रभु साह	51	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
880	HOR	राजेश कुमार	40	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
881	HOR	उध्दव प्रसाद रेग्मी	57	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
882	HOR	देव प्रसाद तिमलसेना	52	पुरुष	Nepali	नेपाली काँग्रेस	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
883	HOR	रुपलाल राय यादव	44	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
884	HOR	अनिल कुमार राम	29	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
885	HOR	राजिव बछार	32	पुरुष	Nepali	मौलिक जरोकिलो पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
886	HOR	अनवरी खाँ	49	महिला	Nepali	नेपाल कम्युनिष्ट पार्टी (मार्क्सवादी लेनिनवादी)	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
887	HOR	सिकन्दर राय यादव	48	पुरुष	Nepali	नेपाल जनता पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
888	HOR	विनोद पासवान	47	पुरुष	Nepali	बहुजन शक्ति पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
889	HOR	कृष्‍ण बहादुर थापा	54	पुरुष	Nepali	आमूल परिवर्तन मसिहा पार्टी नेपाल	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
890	HOR	राजनारायण साह	47	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
891	HOR	भव नाथ शर्मा घिमिरे	76	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
892	HOR	अजय कुमार	60	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
893	HOR	हरेन्द्र झा	39	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
894	HOR	प्रशु नारायण चौधरी	67	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
895	HOR	अबिरल घिमिरे	26	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
896	HOR	चिरन्जीवी गौतम	34	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
897	HOR	प्रदिप विक्रम साह	29	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
898	HOR	ईश्‍वरी कार्की काफ्ले	38	महिला	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	17
899	HOR	अच्युत प्रसाद मैनाली	57	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
900	HOR	उमाकान्त चौधरी	56	पुरुष	Nepali	नेपाली काँग्रेस	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
901	HOR	भक्‍त बहादुर दर्लामी	43	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
902	HOR	मनोज कुमार यादव	28	पुरुष	Nepali	जनमत पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
903	HOR	राकेश न्यौपाने	31	पुरुष	Nepali	हाम्रो नेपाली पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
904	HOR	शिव प्रसाद तिमल्सीना	58	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
905	HOR	महेन्द्र चौधरी	34	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
906	HOR	मोजहर हुसेन मन्सुर	38	पुरुष	Nepali	नेपाल लोकतान्त्रिक पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
907	HOR	धर्मेन्‍द्र प्रसाद	58	पुरुष	Nepali	नेपाली कांग्रेस (बी.पी.)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
908	HOR	प्रदिप कुमार प्रसाद साह कलवार	62	पुरुष	Nepali	नेपाल जनता पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
909	HOR	गणेश धिमाल	39	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
910	HOR	चनकराज भट्टराई	46	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
911	HOR	कृष्ण राज गिरी	81	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
912	HOR	शिव प्रसाद रिजाल	51	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
913	HOR	अनिल कुमार गुप्‍ता	39	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
914	HOR	अनवर अंसारी	51	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
915	HOR	धर्मेन्द्र कुमार साह	27	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
916	HOR	शिवचन्द्र प्रसाद कुशवाहा	56	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (माओवादी केन्द्र)(एकल चुनाव चिन्ह)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
917	HOR	रामसहाय प्रसाद यादव	52	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
918	HOR	सोनालाल प्रसाद सा तेली	52	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
919	HOR	मेरोलाल प्रसाद यादव	28	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
920	HOR	राजेश साह	36	पुरुष	Nepali	जनमत पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
921	HOR	राम प्रसाद	54	पुरुष	Nepali	हाम्रो नेपाली पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
922	HOR	तेज बहादुर भगत	41	पुरुष	Nepali	नागरिक उन्मुक्ति पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
923	HOR	शेख ओली आलम	56	पुरुष	Nepali	नेपालका लागि नेपाली पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
924	HOR	रबिन्द्र प्रसाद जयसवाल	44	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
925	HOR	कमल प्रसाद पसवान	57	पुरुष	Nepali	नेपाल लोकतान्त्रिक पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
926	HOR	उमेश प्रसाद जयसवाल	38	पुरुष	Nepali	नेपाल सुशासन पार्टी(एकल चुनाव चिन्ह)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
927	HOR	अजय प्रसाद चौधरी	54	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
928	HOR	रविन्द्र प्रसाद यादव	50	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
929	HOR	महबुब मियाँ अंसारी	45	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
930	HOR	प्रशान्त कुमार यादव	28	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
931	HOR	अरुण कुमार ज्ञवाली	50	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
932	HOR	मंजारुल अंसारी	49	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
933	HOR	रामकिशोर प्रसाद यादव	52	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
934	HOR	राकेश कुमार यादव	35	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
935	HOR	बिनोद कुमार यादव	47	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
936	HOR	जितेन्द्र प्रसाद यादव	32	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
937	HOR	शम्भु प्रसाद साह	60	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
938	HOR	ज्वाला कुमारी साह	40	महिला	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
939	HOR	रामवावु कुमार यादव	47	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
940	HOR	रुपनारायण ठाकुर लोहार	52	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
941	HOR	महमुदिन मिया अंसारी	52	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
942	HOR	लालबाबु सि‌ह भुइहार	61	पुरुष	Nepali	लोकतान्त्रिक समाजवादी पार्टी, नेपाल	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
943	HOR	राधिका देवी साह	50	महिला	Nepali	जनमत पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
944	HOR	चन्द्र प्रकाश सुवेदी	56	पुरुष	Nepali	हाम्रो नेपाली पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
945	HOR	भिखारी राउत थारु	41	पुरुष	Nepali	नागरिक उन्मुक्ति पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
946	HOR	राजेन्द्र प्रसाद जैसवार	53	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी नेपाल	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
947	HOR	नुर महमद हवारी धोवी	39	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
948	HOR	महम्मद शानी ठकुराई	68	पुरुष	Nepali	नेपाल लोकतान्त्रिक पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
949	HOR	गोपाल दास	58	पुरुष	Nepali	नेपाल जनता पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
950	HOR	अमिरी साह तेली	58	पुरुष	Nepali	विवेकशील साझा पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
951	HOR	नरेश कुमार चौलागाई	40	पुरुष	Nepali	एकीकृत शक्ति नेपाल	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
952	HOR	सुरेन्द्र शर्मा	29	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
953	HOR	कलामुदीन अंसारी	49	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
954	HOR	मनोज प‌डित कुम्हार	39	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
955	HOR	दिनेश्‍वर झा	70	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
956	HOR	एक‍वाल मियाँ	53	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
957	HOR	जलिल देवान	55	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
958	HOR	कृष्ण कुमार श्रेष्ठ	54	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एकिकृत समाजबादी)	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
959	HOR	हरि प्रसाद कुर्मी	63	पुरुष	Nepali	जनमत पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
960	HOR	सन्तोष कुमार गुप्ता	49	पुरुष	Nepali	हाम्रो नेपाली पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
961	HOR	श्रीनिवास महतो	42	पुरुष	Nepali	जनता प्रगतिशिल पार्टी, नेपाल	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
962	HOR	रोहन कुमार	33	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी नेपाल	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
963	HOR	सुनिल प्र साह कलवार	41	पुरुष	Nepali	विवेकशील साझा पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
964	HOR	खेदू महतो धानुक	74	पुरुष	Nepali	नेपाल सद्भावना पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
965	HOR	पवन चौधरी	33	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
966	HOR	दिनेश प्रसाद भेडिहर	42	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
967	HOR	नेमराज प्रसाद जैसवाल	56	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
968	HOR	रामश्रेय प्रसाद कुश्‍वाहा	38	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
969	HOR	इच्छा वहादुर वाग्ले	66	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
970	HOR	गोविन्‍द प्रसाद मंडल	50	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
971	HOR	पुर्ण प्रसाद पन्थ	56	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
972	HOR	किशोरीलाल कुर्मी	52	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
973	HOR	हरि महरा	51	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
974	HOR	हरीनारायण सहनी मलाह	42	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
975	HOR	रामकृष्ण तिवारी	29	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	16
976	HOR	प्रदिप यादव	47	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
977	HOR	किरण मान डंगोल	64	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
978	HOR	मुकेश कुशवाहा	38	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
979	HOR	लक्ष्मण लाल कर्ण	75	पुरुष	Nepali	लोकतान्त्रिक समाजवादी पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
980	HOR	जितेन्‍द्र प्रसाद कुर्मी	35	पुरुष	Nepali	नेपालका लागि नेपाली पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
981	HOR	सुन्दर साह कानु	49	पुरुष	Nepali	नेपाल लोकतान्त्रिक पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
982	HOR	हसिबुर रहमान अंसारी	55	पुरुष	Nepali	राष्ट्रिय जनमुक्ति पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
983	HOR	शंकर प्रसाद चौरसिया	65	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी मार्क्सवादी (पुष्पलाल)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
984	HOR	सुरेश प्रसाद साह	52	पुरुष	Nepali	नेपाल जनता पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
1225	HOR	राम कुमार जि.सी	38	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	35
985	HOR	अजय कुमार रिजाल	55	पुरुष	Nepali	नेपाल सुशासन पार्टी(एकल चुनाव चिन्ह)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
986	HOR	दिलिप कुमार साह तेली	34	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
987	HOR	धर्मेन्द्र साह कानु	32	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
988	HOR	नौशाद अंसारी	27	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
989	HOR	अजय कुमार द्विवेदी	59	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
990	HOR	लखीचन साह तेली	47	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
991	HOR	शंकर कुमार कर्ण	68	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
992	HOR	बालेश्‍वर खाँ चौधरी	38	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
993	HOR	हृदयनारायण प्रसाद बरै	80	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
994	HOR	फरीद आलम	36	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
995	HOR	मोसाहेब मिया मंसुरी	28	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
996	HOR	बरुण चौरसीया	36	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
997	HOR	अजय कुमार चौरसिया	57	पुरुष	Nepali	नेपाली काँग्रेस	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
998	HOR	सुरेन्‍द्र प्रसाद कुर्मी	56	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
999	HOR	नरेश कुमार साह	46	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
1000	HOR	सरोज कुमार साह	39	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
1001	HOR	हरिहर प्रसाद साह(कानु)	68	पुरुष	Nepali	नेपाल लोकतान्त्रिक पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
1002	HOR	उमेश प्रसाद कुर्मी	39	पुरुष	Nepali	नेपाल सद्भावना पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
1003	HOR	सत्यनारायण प्रसाद	56	पुरुष	Nepali	जनसमाजवादी पार्टी नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
1004	HOR	दिपराज पटेल	29	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
1005	HOR	उमेश बरै	44	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
1006	HOR	योगेन्द्र प्रसाद यादव	55	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
1007	HOR	गणेश राज शाह	41	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
1008	HOR	राज कुमार गुप्ता	51	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
1009	HOR	सुरेन्‍द्र प्रसाद चौधरी	64	पुरुष	Nepali	नेपाली काँग्रेस	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
1010	HOR	अंगद ठाकुर	51	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
1011	HOR	आशा काजी वनमाला	45	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
1012	HOR	राज कुमार यादव	54	पुरुष	Nepali	नेपाल सुशासन पार्टी(एकल चुनाव चिन्ह)	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
1013	HOR	अशोक कडेल	29	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
1014	HOR	धुरेन्द्र पटेल	31	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
1015	HOR	रामप्रसाद महतेा चाई	51	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
1016	HOR	प्रदिप कुमार रौनियार	41	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
1017	HOR	सुमिर कुमार साह	35	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
1018	HOR	महमद अली अकबर अंसारी	43	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
1019	HOR	जालिम मियाँ मंसुरी	75	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
1020	HOR	रमेश रिजाल	65	पुरुष	Nepali	नेपाली काँग्रेस	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
1021	HOR	अवधेश प्रसाद गौरो	65	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
1022	HOR	राज कुमार वनमाला	48	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
1023	HOR	अजय कुमार यादव	41	पुरुष	Nepali	जनमत पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
1024	HOR	रामासिस महतो कोइरी	66	पुरुष	Nepali	नेपाली जनता दल	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
1025	HOR	महेन्द्र कुमार चौधरी	44	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
1026	HOR	जज अहमद	41	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
1027	HOR	हेतुला मिया मंसुरी	78	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
1028	HOR	हरिओम साह कानु	36	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	2	15
1029	HOR	बालकृष्ण शिवाकोटी	53	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	26
1030	HOR	ग‌ंगा कार्की	57	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (माओवादी केन्द्र)(एकल चुनाव चिन्ह)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	26
1031	HOR	दावा शेर्पा	43	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	26
1032	HOR	विजय खड्का	56	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	26
1033	HOR	गोपाल बहादुर शिवाकोटी	65	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	26
1034	HOR	गोपाल नेपाली	27	पुरुष	Nepali	लोकतान्त्रिक समाजवादी पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	26
1035	HOR	विश्‍वनीति प्रकाशमान सिंह पाख्रीन	51	पुरुष	Nepali	हाम्रो नेपाली पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	26
1036	HOR	सुक्र तमाङ्ग	41	पुरुष	Nepali	नागरिक उन्मुक्ति पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	26
1037	HOR	नवराज श्रेष्‍ठ भन्ने मिन बहादुर श्रेष्‍ठ	46	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	26
1038	HOR	खिम बहादुर शिवाकोटी	32	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (मार्क्सवादी लेनिनवादी)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	26
1039	HOR	कुमार तामाङ्ग	36	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	26
1040	HOR	लोक  बहादुर खड्का	41	पुरुष	Nepali	नेपाली कांग्रेस (बी.पी.)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	26
1041	HOR	जनार्दन पोखरेल	62	पुरुष	Nepali	जनसमाजवादी पार्टी नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	26
1042	HOR	जगदीश खरेल	33	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	26
1043	HOR	राम बहादुर सुवेदी	42	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	26
1044	HOR	टंक बहादुर खाती	33	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	26
1045	HOR	विर बहादुर कार्की	48	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	26
1046	HOR	यज्ञ राज न्यौपाने	45	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	26
1047	HOR	जीवनाथ शिवाकोटी	34	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	26
1048	HOR	बद्री दाहाल	39	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	26
1049	HOR	ठाकुर बहादुर बुढाथोकी	46	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	26
1050	HOR	प्रदिप कुमार कटुवाल क्षेत्री (के सी)	60	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	34
1051	HOR	श्‍याम कुमार घिमिरे	58	पुरुष	Nepali	नेपाली काँग्रेस	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	34
1052	HOR	सोम नाथ अधिकारी	36	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	34
1053	HOR	शालीग्राम माझी	36	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	34
1054	HOR	चित्र लाल श्रेष्ठ	41	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	34
1055	HOR	धन कुमार राई	29	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	34
1056	HOR	हिरण्य लाल श्रेष्ठ	64	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी मार्क्सवादी (पुष्पलाल)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	34
1057	HOR	फणिन्‍द्र बहादुर श्रेष्‍ठ	48	पुरुष	Nepali	एकीकृत शक्ति नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	34
1058	HOR	मेनुका ठकुरी	31	महिला	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	34
1059	HOR	डम्वर बहादुर वि. क.	29	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	34
1060	HOR	कृष्ण हरी पौडेल	52	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	34
1061	HOR	राम हरी वुढाथोकी	69	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	34
1062	HOR	मनोज जंग थापा	54	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	34
1063	HOR	लेख नाथ दाहाल	46	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (माओवादी केन्द्र)(एकल चुनाव चिन्ह)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	34
1064	HOR	भिष्म राज श्रेष्‍ठ	52	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	34
1065	HOR	रामेश्‍वरी कोजु	37	महिला	Nepali	नेपाल मजदुर किसान पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	34
1066	HOR	डिल्ली कुमार गोले	50	पुरुष	Nepali	तामाङसालिङ लोकतान्त्रिक पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	34
1067	HOR	शान्त वीर लामा	39	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	34
1068	HOR	योग्य बहादुर मुडुला कार्की	32	पुरुष	Nepali	जनसमाजवादी पार्टी नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	34
1069	HOR	अनोज कुमार दाहाल	29	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	34
1070	HOR	भुपेन्द्र विश्‍वकर्मा	30	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	34
1071	HOR	छोवाङ तेन्जीन तामङ्ग	62	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	33
1072	HOR	मोहन आचार्य	45	पुरुष	Nepali	नेपाली काँग्रेस	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	33
1073	HOR	टिका प्रसाद देवकोटा	37	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	33
1074	HOR	रामेश्वर बासी	46	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	33
1075	HOR	विकाश  गलान	34	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	33
1076	HOR	सृजना सुनुवार	26	महिला	Nepali	जनसमाजवादी पार्टी नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	33
1077	HOR	मिन नाथ देबकोटा	57	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	33
1078	HOR	राम शरण पौडेल	41	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	33
1079	HOR	लिला बहादुर न्यौपाने	53	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	33
1080	HOR	कर्सा वाङदी तमाङ	37	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	33
1081	HOR	बद्री मैनाली	46	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	31
1082	HOR	हित बहादुर तामाङ	59	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (माओवादी केन्द्र)(एकल चुनाव चिन्ह)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	31
1083	HOR	देव राज घिमिरे	48	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	31
1084	HOR	सुदर्शन सिटौला	50	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	31
1085	HOR	रविन्द्र डंगोल	35	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	31
1086	HOR	लक्ष्मी रसाइली	29	महिला	Nepali	लोकतान्त्रिक समाजवादी पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	31
1087	HOR	सफलता बोगटी	28	महिला	Nepali	हाम्रो नेपाली पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	31
1088	HOR	पुष्पा न्यौपाने	45	महिला	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	31
1089	HOR	केशव प्रसाद उप्रेती	37	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (मार्क्सवादी लेनिनवादी)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	31
1090	HOR	सुरेन्द्र तामाङ	28	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	31
1091	HOR	भुवन तामाङ	26	पुरुष	Nepali	संघीय लोकतान्त्रिक राष्ट्रिय मञ्च	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	31
1092	HOR	श्‍याम बहादुर गुरुङ्ग	55	पुरुष	Nepali	नेपाली कांग्रेस (बी.पी.)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	31
1093	HOR	निमेश तमाङ	37	पुरुष	Nepali	जनसमाजवादी पार्टी नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	31
1094	HOR	प्रधुम्न महत क्षेत्री	41	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	31
1095	HOR	निर्मल लामिछाने	28	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	31
1096	HOR	जितेन्द्र सिं ठकुरी	39	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	31
1097	HOR	राजकुमार बस्नेत	43	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	31
1098	HOR	नारायण प्रसाद खतिवडा	65	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	31
1099	HOR	अर्जुन नरसिंह के.सी.	75	पुरुष	Nepali	नेपाली काँग्रेस	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	31
1100	HOR	झनक प्याकुरेल	54	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	31
1101	HOR	गणेश मान वाटांकछी	61	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	31
1102	HOR	धन कुमारी सुनार	35	महिला	Nepali	लोकतान्त्रिक समाजवादी पार्टी, नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	31
1103	HOR	प्रेम माया तामाङ	29	महिला	Nepali	मंगोल नेशनल अर्गनाइजेसन	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	31
1104	HOR	हिमाल जोशी	32	पुरुष	Nepali	जनसमाजवादी पार्टी नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	31
1105	HOR	शुमन बिक्रम पाण्डे	57	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	31
1106	HOR	सुर्दशन पुडासैनी	30	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	31
1107	HOR	विनोद कुमार तामाङ	26	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	31
1108	HOR	गायत्री दाहाल	40	महिला	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	31
1109	HOR	नवराज गेलाल	57	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	23
1110	HOR	सुनिल गोठे	40	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (माओवादी केन्द्र)(एकल चुनाव चिन्ह)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	23
1111	HOR	हिरा लाल खड्का	55	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	23
1112	HOR	भरत बहादुर खड्का	60	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	23
1113	HOR	प्रेम सुवाल	62	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	23
1114	HOR	वल राम प्रजापति	36	पुरुष	Nepali	मौलिक जरोकिलो पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	23
1115	HOR	अर्जुन प्रसाद नेपाल	59	पुरुष	Nepali	नेपालका लागि नेपाली पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	23
1116	HOR	माधव खत्री	46	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	23
1117	HOR	दिपक लामीछाने	53	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (मार्क्सवादी लेनिनवादी)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	23
1118	HOR	डम्वर बहादुर थिङ्ग	38	पुरुष	Nepali	आमूल परिवर्तन मसिहा पार्टी नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	23
1119	HOR	अर्जुन कोजू	31	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	23
1120	HOR	पुष्प राम गेलाल	39	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	23
1121	HOR	सुलोचना छ्वाजु	36	महिला	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	23
1122	HOR	गोकर्ण प्रसाद गेलाल	39	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	23
1123	HOR	महेश बस्नेत	47	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	23
1124	HOR	दुर्लभ थापा क्षेत्री	54	पुरुष	Nepali	नेपाली काँग्रेस	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	23
1125	HOR	दिल बहादुर तामाङ्ग	42	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	23
1126	HOR	मोहन के.सी	65	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	23
1127	HOR	अनुराधा थापा मगर	40	महिला	Nepali	नेपाल मजदुर किसान पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	23
1128	HOR	लिला बहादुर बानियाँ	61	पुरुष	Nepali	मौलिक जरोकिलो पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	23
1129	HOR	लोकेन्द्र पोखरेल	43	पुरुष	Nepali	हाम्रो नेपाली पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	23
1130	HOR	राजेश बाडे	35	पुरुष	Nepali	नेपालका लागि नेपाली पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	23
1131	HOR	राजु नापित	45	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	23
1132	HOR	शशी बिक्रम कार्की	40	पुरुष	Nepali	नेपाल विवेकशील पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	23
1133	HOR	शिव लाल रोकाया	51	पुरुष	Nepali	नेश्नलिष्ट पिपल्स पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	23
1134	HOR	राजु श्रेष्ठ	48	पुरुष	Nepali	राष्ट्रिय जनमुक्ति पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	23
1135	HOR	शन्त बहादुर लाकाजु	44	पुरुष	Nepali	आमूल परिवर्तन मसिहा पार्टी नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	23
1136	HOR	इन्द्र नारायण न्हुछे श्रेष्‍ठ	44	पुरुष	Nepali	नेपाल आमा पार्टी(एकल चुनाव चिन्ह)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	23
1137	HOR	साजन वि.क.	29	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	23
1138	HOR	मिना कुमारी वाला	41	महिला	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	23
1139	HOR	कल्प दिप राई	47	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	23
1140	HOR	सुमन कार्की	41	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	23
1141	HOR	सुर्वण थापा	44	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	23
1142	HOR	मोक्टो तामाङ	51	महिला	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	23
1143	HOR	रञ्जु के.सी	47	महिला	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	23
1144	HOR	प्रमिला थापा	46	महिला	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	23
1145	HOR	दिनेश प्रजापती	51	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	23
1146	HOR	चम्पा बोगती	39	महिला	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	23
1147	HOR	उमेश श्रेष्‍ठ	44	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	23
1148	HOR	आनन्द कार्की	38	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	23
1149	HOR	नव राज सिलवाल	59	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1150	HOR	उदय शंशेर ज.ब.राणा	52	पुरुष	Nepali	नेपाली काँग्रेस	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1151	HOR	गोपाल राज राई	49	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1152	HOR	सन्दिप आचार्य	27	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1153	HOR	कविन्द्र डंगोल	43	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1154	HOR	मनिष बहादुर श्रेष्ठ	41	पुरुष	Nepali	लोकतान्त्रिक समाजवादी पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1155	HOR	सुर्य तामाङ्ग बल	36	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1294	HOR	देविका कुवर	29	महिला	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1156	HOR	सुभद्रा महर्जन	47	महिला	Nepali	नेश्नलिष्ट पिपल्स पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1157	HOR	बालकृष्ण घिमिरे	57	पुरुष	Nepali	राष्ट्रिय जनमुक्ति पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1158	HOR	विष्णु लामा	32	महिला	Nepali	आमूल परिवर्तन मसिहा पार्टी नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1159	HOR	सचिन कुमार घिमिरे	44	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1160	HOR	गोविन्द घिमिरे के.सी.	40	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1161	HOR	सुमन भुम्जन	29	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1162	HOR	राज कुमार तिमिल्सिना	49	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1163	HOR	फूल माया लो	47	महिला	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1164	HOR	नवराज घिमिरे	49	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1165	HOR	विशाल तामाङ	42	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1166	HOR	भुपेन्द्र सिल्वाल	47	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1167	HOR	गोकुल तिमल्सिना	32	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1168	HOR	शैलेन्द्र बिष्ट	41	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1169	HOR	कृष्‍ण काजी महर्जन	53	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1170	HOR	प्रेम बहादुर महर्जन	56	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1171	HOR	रघुवर राज थापा	53	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1172	HOR	राज वीर डंगोल	49	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1173	HOR	लक्ष्मण शाही	37	पुरुष	Nepali	लोकतान्त्रिक समाजवादी पार्टी, नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1174	HOR	कृष्ण लाल महर्जन	67	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एकिकृत समाजबादी)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1175	HOR	सुदिन शाक्य	45	पुरुष	Nepali	हाम्रो नेपाली पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1176	HOR	खेम प्रसाद श्रेष्ठ	61	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1177	HOR	भुवान सिं लिम्बु	59	पुरुष	Nepali	संघीय लोकतान्त्रिक राष्ट्रिय मञ्च	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1178	HOR	निरञ्जन गणेश	55	पुरुष	Nepali	नेश्नलिष्ट पिपल्स पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1179	HOR	सुरोज अवाले	41	पुरुष	Nepali	राष्ट्रिय जनमुक्ति पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1180	HOR	सुरेश महर्जन	40	पुरुष	Nepali	एकीकृत शक्ति नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1181	HOR	जय बहादुर खत्री	68	पुरुष	Nepali	नेपाल सुशासन पार्टी(एकल चुनाव चिन्ह)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1182	HOR	शिव पौडेल	45	पुरुष	Nepali	जनसमाजवादी पार्टी नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1183	HOR	बुद्ध रत्न महर्जन	44	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1184	HOR	संजीव चौधरी	40	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1185	HOR	ऋषि राज भेटवाल	48	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1186	HOR	दीपेश कुमार के.सी.	39	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1187	HOR	सरिना लाखे (श्रेष्‍ठ)	49	महिला	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1188	HOR	बिकास शाक्य	42	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1189	HOR	हेरा काजी अवाले	52	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1190	HOR	निरज भक्त माथेमा	39	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1191	HOR	राधिका सुवेदी	45	महिला	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1192	HOR	अमृत खड्का	49	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1193	HOR	पम्फा भुसाल	60	महिला	Nepali	नेपाल कम्युनिष्ट पार्टी (माओवादी केन्द्र)(एकल चुनाव चिन्ह)	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1194	HOR	निरन्जन थापा	40	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1195	HOR	निरज लवजू	37	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1196	HOR	किरण शाही	34	पुरुष	Nepali	लोकतान्त्रिक समाजवादी पार्टी, नेपाल	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1197	HOR	धिरेन्द्र सोडारी	29	पुरुष	Nepali	मौलिक जरोकिलो पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1198	HOR	राजा राम तण्डुकार	49	पुरुष	Nepali	हाम्रो नेपाली पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1199	HOR	राजेन्द्र प्रसाद ओझा	56	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी नेपाल	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1200	HOR	बिष्‍णु कुमार लिम्‍बु	70	पुरुष	Nepali	संघीय लोकतान्त्रिक राष्ट्रिय मञ्च	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1201	HOR	चिरञ्जीवि सापकोटा	39	पुरुष	Nepali	नेश्नलिष्ट पिपल्स पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1202	HOR	सपना महर्जन	36	महिला	Nepali	आमूल परिवर्तन मसिहा पार्टी नेपाल	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1203	HOR	कविता राई	44	महिला	Nepali	नेपाल आमा पार्टी(एकल चुनाव चिन्ह)	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1204	HOR	तोसीमा कार्की	33	महिला	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1205	HOR	रघुनाथ के सी	56	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1206	HOR	राधे श्याम खड्का	46	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1207	HOR	कृष्ण भक्त ब्रम्हचार्य	53	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1208	HOR	चिरन थापा	51	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1209	HOR	विष्‍णु महर्जन	44	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1210	HOR	जेसन देज वैध्य	47	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1211	HOR	संजय महर्जन	33	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	29
1212	HOR	सरेश नेपाल	61	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	35
1213	HOR	माधव सापकोटा	41	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (माओवादी केन्द्र)(एकल चुनाव चिन्ह)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	35
1214	HOR	डिवी सिंह लामा	33	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	35
1215	HOR	नारायण पाण्डे	66	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	35
1216	HOR	हरि लक्ष्मी दनेखू	38	महिला	Nepali	नेपाल मजदुर किसान पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	35
1217	HOR	विर बहादुर तामाङ्‍ग	54	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	35
1218	HOR	कृष्ण बहादुर ठकुरी	70	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (मार्क्सवादी लेनिनवादी)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	35
1219	HOR	दावा लामा	34	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	35
1220	HOR	ग्याल्जेन शेर्पा	42	पुरुष	Nepali	संघीय लोकतान्त्रिक राष्ट्रिय मञ्च	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	35
1221	HOR	सोम नोर्बु शेर्पा	38	पुरुष	Nepali	आमूल परिवर्तन मसिहा पार्टी नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	35
1222	HOR	दिनेश श्रेष्‍ठ	36	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	35
1223	HOR	बिष्णु प्रसाद पौडेल	43	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	35
1224	HOR	मुकुन्द श्रेष्ठ	30	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	35
1226	HOR	शेर बहादुर तामाङग	53	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	35
1227	HOR	मोहन बहादुर बस्नेत	64	पुरुष	Nepali	नेपाली काँग्रेस	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	35
1228	HOR	नर सिं श्रेष्ठ	59	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	35
1229	HOR	लक्ष्मी प्रसाद कुसी	49	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	35
1230	HOR	मंगल सिं तामाङ	39	पुरुष	Nepali	जनमत पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	35
1231	HOR	दिलीप वि.क.	43	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	35
1232	HOR	कवि राज गिरी	56	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (मार्क्सवादी लेनिनवादी)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	35
1233	HOR	कर्णविर स्यांवु लामा	36	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	35
1234	HOR	दावा छिरिङ शेर्पा	46	पुरुष	Nepali	संघीय लोकतान्त्रिक राष्ट्रिय मञ्च	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	35
1235	HOR	श्याम बहादुर तामाङ्ग	48	पुरुष	Nepali	आमूल परिवर्तन मसिहा पार्टी नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	35
1236	HOR	माया गुरुङ्ग	42	महिला	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	35
1237	HOR	ध्रुव प्रसाद पराजुली	56	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	35
1238	HOR	बद्री प्रसाद चौलागाई	47	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	35
1239	HOR	कमल थापा	67	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	30
1240	HOR	महालक्ष्मी उपाध्याय(डिना)	58	महिला	Nepali	नेपाली काँग्रेस	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	30
1241	HOR	इन्द्र मान थिङ	37	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	30
1242	HOR	दिपक बहादुर सिंह	61	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	30
1243	HOR	सान्त लाल भैल	60	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	30
1244	HOR	रुपक लामा	44	पुरुष	Nepali	लोकतान्त्रिक समाजवादी पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	30
1245	HOR	सङ्गीन श्रेष्‍ठ	38	पुरुष	Nepali	मौलिक जरोकिलो पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	30
1246	HOR	दिपेन्द्र चन्द ठकुरी	46	पुरुष	Nepali	हाम्रो नेपाली पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	30
1247	HOR	कृष्ण प्रसाद दाहाल	60	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (मार्क्सवादी लेनिनवादी)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	30
1248	HOR	युवराज लामा	40	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	30
1249	HOR	सुरेन्द्र भट्टराई	43	पुरुष	Nepali	नेपाली कांग्रेस (बी.पी.)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	30
1250	HOR	पंच लाल तमाङ	42	पुरुष	Nepali	सचेत नेपाली पार्टी(एकल चुनाव चिन्ह)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	30
1251	HOR	मन बहादुर दाहाल	53	पुरुष	Nepali	जनसमाजवादी पार्टी नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	30
1252	HOR	टाका राज थापा	35	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	30
1253	HOR	आईताराम तामाङ	43	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	30
1254	HOR	सुभाष पौडेल	36	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	30
1255	HOR	महेश कुमार वर्तौला	40	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	30
1256	HOR	राजन मैनाली	57	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	30
1257	HOR	रत्‍न प्रसाद प्रजापति	51	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	30
1258	HOR	विरोध खतिवडा	62	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एकिकृत समाजबादी)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	30
1259	HOR	उद्धव प्रसाद अधिकारी	60	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (मार्क्सवादी लेनिनवादी)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	30
1260	HOR	जीवन स्‍याङतान	40	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	30
1261	HOR	तुला बहादुर लामा	46	पुरुष	Nepali	नेश्नलिष्ट पिपल्स पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	30
1262	HOR	कुलेन्द्र दिप विक्रम न्यौपाने	39	पुरुष	Nepali	सचेत नेपाली पार्टी(एकल चुनाव चिन्ह)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	30
1263	HOR	भरत पराजुली	54	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	30
1264	HOR	प्रदिप कालाखेती	33	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	30
1265	HOR	सुरेन्द्र प्रसाद पाण्डे	64	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1266	HOR	विश्‍वनाथ पौडेल	47	पुरुष	Nepali	नेपाली काँग्रेस	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1267	HOR	अजय ठाकुर हजाम	36	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1268	HOR	मधुप कुमार भट्टराई	58	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1269	HOR	अर्जुन प्रजा	26	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1270	HOR	कुमारी थिङ्ग	29	महिला	Nepali	मंगोल नेशनल अर्गनाइजेसन	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1271	HOR	नविन खड्का	39	पुरुष	Nepali	एकीकृत शक्ति नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1272	HOR	गोविन्द प्रसाद रिजाल	60	पुरुष	Nepali	नेपाल सुशासन पार्टी(एकल चुनाव चिन्ह)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1273	HOR	हरि ढकाल	39	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1274	HOR	जिवन तमाङ्ग	49	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1275	HOR	बिष्णु लामा	54	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1276	HOR	दिपक पाठक	40	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1277	HOR	अरुण कुमार उप्रेती	40	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1278	HOR	ओमकृष्ण थपलिया	28	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1279	HOR	तिलक मणी पाठक	30	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1280	HOR	उत्सव धमला	29	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1281	HOR	राजेन्द्र प्रसाद वुर्लाकोटी	63	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1282	HOR	कुमार आचार्य	63	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1283	HOR	राजन न्यौपाने	45	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1284	HOR	कृष्ण भक्त पोख्रेल	55	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1285	HOR	उमेश श्रेष्ठ	66	पुरुष	Nepali	नेपाली काँग्रेस	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1286	HOR	मुस्तफा अली	64	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1287	HOR	रविन अधिकारी	36	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1288	HOR	ज्ञानेन्द्र प्रजा	31	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1289	HOR	अमृत तामाङ्ग	41	पुरुष	Nepali	हाम्रो नेपाली पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1290	HOR	सुनिल कुमार क्षेत्री	45	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1291	HOR	टेक बहादुर तामाङ	47	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1292	HOR	प्रभा त्रिपाठी	41	महिला	Nepali	जनसमाजवादी पार्टी नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1293	HOR	रबि लामिछाने	47	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1295	HOR	भास्कर चन्द्र न्यौपाने	51	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1296	HOR	खेम राज भट्टराई	48	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1297	HOR	अंगुर पन्त	43	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1298	HOR	शुदर्शन प्रधान	59	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1299	HOR	सुन्दर डल्लाकोटी	35	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1300	HOR	भोज राज अधिकारी	42	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (माओवादी केन्द्र)(एकल चुनाव चिन्ह)	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1301	HOR	काशीम मिया	34	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1302	HOR	विक्रम पाण्डे	69	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1303	HOR	पदम थापा मगर	34	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1304	HOR	नवराज घले	47	पुरुष	Nepali	राष्ट्रिय नागरिक पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1305	HOR	फैन्द्र जंङ गुरुङ्ग	52	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1306	HOR	जग बहादुर पुन मगर	56	पुरुष	Nepali	राष्ट्रिय जनमुक्ति पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1307	HOR	जीता वराल	43	महिला	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1308	HOR	राजन सापकोटा	32	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1309	HOR	तारानाथ पौडेल	50	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1310	HOR	दिनेश कोइराला	51	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1311	HOR	सुमित्रा राई गिरी	42	महिला	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1312	HOR	जगन्नाथ पौडेल	71	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1313	HOR	भिम्सीन बस्नेत	47	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1314	HOR	नन्द राज उपाध्याय	34	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1315	HOR	बासुदेव सापकोटा	33	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1316	HOR	बद्रि सिलवाल	26	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1317	HOR	हरि तमाङ्ग	61	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1318	HOR	तारा प्रसाद पौडेल	41	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1319	HOR	चन्द्र विलास अधिकारी	32	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	24
1320	HOR	राम शरण वस्नेत	60	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	37
1321	HOR	राजेन्द्र बजगाई	49	पुरुष	Nepali	नेपाली काँग्रेस	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	37
1322	HOR	रुपेश राना	36	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	37
1323	HOR	उदय प्रसाद भट्ट	47	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	37
1324	HOR	लिला कुमारी बुढाथोकी	50	महिला	Nepali	नेपाल मजदुर किसान पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	37
1325	HOR	देव बहादुर थापा	26	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	37
1326	HOR	मिन कुमार श्रेष्ठ	38	पुरुष	Nepali	नेपाल सुशासन पार्टी(एकल चुनाव चिन्ह)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	37
1327	HOR	उत्तर बहादुर खड्का	51	पुरुष	Nepali	जनसमाजवादी पार्टी नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	37
1328	HOR	सुवर्ण रोकाहा	43	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	37
1329	HOR	बिष्णु पुडासैनी	28	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	37
1330	HOR	अब्दुस सलाम मिया	29	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	37
1331	HOR	पुष्प कमल दाहाल {प्रचन्ड}	66	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (माओवादी केन्द्र)(एकल चुनाव चिन्ह)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	37
1332	HOR	सुशिल पन्त	46	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	37
1333	HOR	प्रलाद लामिछाने	46	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	37
1334	HOR	प्रकाश थापा	56	पुरुष	Nepali	हाम्रो नेपाली पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	37
1335	HOR	कुल बहादुर बस्नेत	54	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	37
1336	HOR	नारायण बाबु आचार्य	58	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (मार्क्सवादी लेनिनवादी)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	37
1337	HOR	सोम बहादुर गरुङ	40	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	37
1338	HOR	टिका दत्त पोखरेल	99	पुरुष	Nepali	नेपाली कांग्रेस (बी.पी.)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	37
1339	HOR	कविन्द्र बुर्लाकोटी	42	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	37
1340	HOR	गणेश देवकोटा	52	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	37
1341	HOR	विनोद कुमार गुरुङ	44	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	37
1342	HOR	मन बहादुर गुरुङ्ग	56	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	38
1343	HOR	किशोर दत्त बराल	57	पुरुष	Nepali	नेपाली काँग्रेस	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	38
1344	HOR	शमिला नेपाली मंग्राती	34	महिला	Nepali	जनता समाजवादी पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	38
1345	HOR	सूर्य बहादुर गुरुङ	64	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	38
1346	HOR	राजेन्द्र माक	42	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	38
1347	HOR	प्रमोद आचार्य	41	पुरुष	Nepali	हाम्रो नेपाली पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	38
1348	HOR	टुक बहादुर सिंजाली	43	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी माओवादी समाजवादी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	38
1349	HOR	यज्ञ वहादुर गुरुङ्ग	38	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	38
1350	HOR	सिता श्रीस मगर	35	महिला	Nepali	राष्ट्रिय जनमुक्ति पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	38
1351	HOR	सविना वेगम	41	महिला	Nepali	एकीकृत शक्ति नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	38
1352	HOR	शिव प्रसाद अधिकारी	40	पुरुष	Nepali	आमूल परिवर्तन मसिहा पार्टी नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	38
1353	HOR	राजु राई	43	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	38
1354	HOR	सौगात जि सी	27	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	38
1355	HOR	दिल वहादुर राना	46	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	38
1356	HOR	विधा भटटराई	49	महिला	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	38
1357	HOR	बुद्धि कुमारी गुरुङ्ग	61	महिला	Nepali	जनता समाजवादी पार्टी, नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	38
1358	HOR	सुवर्ण राज पन्त	32	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	38
1359	HOR	पशुपति प्रजापती	55	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	38
1360	HOR	श्रीनाथ वराल	54	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एकिकृत समाजबादी)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	38
1361	HOR	महेन्द्र शर्मा	52	पुरुष	Nepali	जनमत पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	38
1362	HOR	शिरिष गुरुङ	36	महिला	Nepali	हाम्रो नेपाली पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	38
1363	HOR	ज्ञान राज गुरुङ्ग	53	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	38
1364	HOR	बाल कुमार राई	30	पुरुष	Nepali	संघीय लोकतान्त्रिक राष्ट्रिय मञ्च	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	38
1365	HOR	ईश्‍वर वहादुर राना	49	पुरुष	Nepali	राष्ट्रिय जनमुक्ति पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	38
1366	HOR	गिता बहादुर रेाका	43	पुरुष	Nepali	आमूल परिवर्तन मसिहा पार्टी नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	38
1367	HOR	माधव प्रसाद कंडेल	53	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	38
1368	HOR	महादेव गुरुङ	66	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	38
1369	HOR	तारानाथ सुवेदी	78	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	38
1370	HOR	जमुना शर्मा	32	महिला	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	38
1371	HOR	गिता नाथ	35	महिला	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	38
1372	HOR	ऋगेन्द्र गिरी	34	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	38
1373	HOR	दामोदर पौडेल वैरागी	56	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	38
1374	HOR	रामजी प्रसाद बराल जीवन	56	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (माओवादी केन्द्र)(एकल चुनाव चिन्ह)	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	38
1375	HOR	हित काजी गुरुङ्ग	58	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	38
1376	HOR	जगत प्रसाद सुवेदी	67	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	38
1377	HOR	बल राम सिबन्जार	45	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	38
1378	HOR	विवेक कुमार पौडयल	33	पुरुष	Nepali	हाम्रो नेपाली पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	38
1379	HOR	गंगा कुमारी खपाङगी तामाङ	37	महिला	Nepali	मंगोल नेशनल अर्गनाइजेसन	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	38
1380	HOR	योग राज पौडेल	41	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	38
1381	HOR	दुर्गा प्रसाद कोइराला	61	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	38
1382	HOR	पशुपती नाथ तिमिल्सिना	84	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	38
1383	HOR	कमल जङ्ग कुँवर	50	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	38
1384	HOR	ढक बहादुर कार्की	52	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	38
1385	HOR	अनिता भुर्त्याल	36	महिला	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	38
1386	HOR	यादव प्रसाद तिमिल्सेना	38	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	38
1387	HOR	टंक प्रसाद अधिकारी	50	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	38
1388	HOR	एक बहादुर राना मगर	63	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	46
1389	HOR	रामचन्द्र पौडेल	78	पुरुष	Nepali	नेपाली काँग्रेस	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	46
1390	HOR	पासाङ थापा मगर	35	महिला	Nepali	जनता समाजवादी पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	46
1391	HOR	विनोद कुमार घर्ती	39	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	46
1392	HOR	राम कृष्ण त्वायना	54	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	46
1393	HOR	प्रविन पौडेल	31	पुरुष	Nepali	हाम्रो नेपाली पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	46
1394	HOR	कृष्ण प्रसाद पौडेल	65	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	46
1395	HOR	प्रेम बहादुर थापा	41	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	46
1396	HOR	ताज महमद मिया	37	पुरुष	Nepali	नेश्नलिष्ट पिपल्स पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	46
1397	HOR	हस्त बहादुर किचिम थापा	70	पुरुष	Nepali	राष्ट्रिय जनमुक्ति पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	46
1398	HOR	विकास सिग्देल	30	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	46
1399	HOR	गोविन्द राज जोशी	73	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	46
1400	HOR	राम चन्द्र कार्की	52	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	46
1401	HOR	बेल बहादुर दरै	35	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	46
1402	HOR	पृथ्वी नारायण श्रेष्ठ	51	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	46
1403	HOR	किरण गुरुङ	61	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	46
1404	HOR	शंकर भण्डारी	54	पुरुष	Nepali	नेपाली काँग्रेस	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	46
1405	HOR	नरेन्द्र प्रताप महत	64	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	46
1406	HOR	राम हरि गोरा	57	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	46
1407	HOR	विष्णु पराजुली	36	पुरुष	Nepali	हाम्रो नेपाली पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	46
1408	HOR	प्रविना थापा मगर	36	महिला	Nepali	मंगोल नेशनल अर्गनाइजेसन	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	46
1409	HOR	लाल बहादुर सार्की गोतामे	37	पुरुष	Nepali	राष्ट्रिय जनमुक्ति पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	46
1410	HOR	पुष्प राज पराजुली	57	पुरुष	Nepali	नेपाली कांग्रेस (बी.पी.)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	46
1411	HOR	खड्क बहादुर वि.क	50	पुरुष	Nepali	जनसमाजवादी पार्टी नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	46
1412	HOR	बिजय जोशी	36	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	46
1413	HOR	हरीकृष्ण श्रेष्ठ	57	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	42
1414	HOR	खम बहादुर गर्बुजा	57	पुरुष	Nepali	नेपाली काँग्रेस	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	42
1415	HOR	जगत प्रसाद गौचन	66	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	42
1416	HOR	ओम राज मगर	31	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	42
1417	HOR	बिष्णु घिमिरे खत्री	28	महिला	Nepali	नेश्नलिष्ट पिपल्स पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	42
1418	HOR	हरी बहादुर खत्री क्षेत्री	37	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	42
1419	HOR	विनोद भट्टचन	58	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	42
1420	HOR	खील बहादुर बरुवाल	47	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	42
1421	HOR	नविन जी.सी.	31	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	42
1422	HOR	सुर्य प्रसाद पाठक	46	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	36
1423	HOR	लक्ष्मी प्रसाद सापकोटा	52	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	36
1424	HOR	चित्र बहादुर के.सी.	80	पुरुष	Nepali	राष्ट्रिय जनमोर्चा	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	36
1425	HOR	शिवलाल सापकोटा	61	पुरुष	Nepali	नेपाली कांग्रेस (बी.पी.)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	36
1426	HOR	खिमानन्द कँडेल	42	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	36
1427	HOR	चन्द्र बहादुर क्षेत्री	46	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	36
1428	HOR	मन्जु शर्मा	48	महिला	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	36
1429	HOR	देवेन्द्र पौडेल	57	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (माओवादी केन्द्र)(एकल चुनाव चिन्ह)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	36
1430	HOR	चित्र प्रसाद गुरुङ	59	पुरुष	Nepali	राष्ट्रिय जनमुक्ति पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	36
1431	HOR	टेक प्रसाद कामी	55	पुरुष	Nepali	नेपाल दलित पार्टी(एकल चुनाव चिन्ह)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	36
1432	HOR	तिला खत्री	41	महिला	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	36
1433	HOR	डिल बहादुर कार्की	56	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	36
1434	HOR	तुल्सी राम अर्याल	56	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	36
1435	HOR	प्रदिप कुमार ज्ञवाली	61	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	51
1436	HOR	चन्द्रकान्त भण्डारी	61	पुरुष	Nepali	नेपाली काँग्रेस	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	51
1437	HOR	गणेश पाण्डे	31	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	51
1438	HOR	पदम रसाईली	31	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	51
1439	HOR	भुवनेश्‍वर अर्याल	52	पुरुष	Nepali	हाम्रो नेपाली पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	51
1440	HOR	लोक बहादुर थापा	36	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	51
1441	HOR	चन्दा थापा	44	महिला	Nepali	राष्ट्रिय जनमुक्ति पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	51
1442	HOR	दामोदर भण्डारी	44	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	51
1443	HOR	सुधन न्यौपाने	27	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	51
1444	HOR	कमला श्रेष्ठ	36	महिला	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	51
1445	HOR	गोकर्ण राज विष्‍ट	57	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	51
1446	HOR	युव राज घिमिरे	48	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	51
1447	HOR	राम कुमारी झाक्री	44	महिला	Nepali	नेपाल कम्युनिष्ट पार्टी (एकिकृत समाजबादी)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	51
1448	HOR	रामलाल पाण्डे	50	पुरुष	Nepali	हाम्रो नेपाली पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	51
1449	HOR	ठाकुर प्रसाद पाण्डेय	57	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	51
1450	HOR	पदम थापा मगर	45	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	51
1451	HOR	तेजेन्द्र बहादुर महत	27	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	51
1452	HOR	नारायण भट्टराई	28	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	51
1453	HOR	कमला पुन	36	महिला	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	51
1454	HOR	देवराज पाण्डे	30	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	51
1455	HOR	दामोदर भुसाल	49	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	51
1456	HOR	अमर बहादुर कार्की	26	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	51
1457	HOR	केशर बहादुर थापा	62	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	51
1458	HOR	नारायण प्रसाद आचार्य	52	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	52
1459	HOR	ज्ञान बहादुर गाहा	49	पुरुष	Nepali	नेपाली काँग्रेस	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	52
1460	HOR	मेहरमान राना	39	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	52
1461	HOR	ज्ञान  बहादुर  सिंजाली	63	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	52
1462	HOR	थम्मन बहादुर बुढा मगर	36	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	52
1463	HOR	उजर सिं दर्लामी	45	पुरुष	Nepali	राष्ट्रिय जनमुक्ति पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	52
1464	HOR	राजु सुनार	33	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	52
1465	HOR	विपिन कडेल	29	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	52
1466	HOR	नारायण न्यौपाने	35	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	52
1467	HOR	डोल राज तिमिल्सिना	51	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	52
1468	HOR	ठाकुर प्रसाद गैरे	54	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	52
1469	HOR	दुर्पता सोमै	54	महिला	Nepali	जनता समाजवादी पार्टी, नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	52
1470	HOR	शिव सुन्दर धुख्वा	46	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	52
1471	HOR	सोम प्रसाद पाण्डेय	67	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एकिकृत समाजबादी)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	52
1472	HOR	खडानन्द गैरे	45	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	52
1473	HOR	मन बहादुर दर्लामी	48	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	52
1474	HOR	हुम बहादुर थापा मगर	62	पुरुष	Nepali	राष्ट्रिय जनमुक्ति पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	52
1475	HOR	तारा बहादुर खत्री	59	पुरुष	Nepali	नेपाल आमा पार्टी(एकल चुनाव चिन्ह)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	52
1476	HOR	देव बहादुर हिस्की	45	पुरुष	Nepali	जनसमाजवादी पार्टी नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	52
1477	HOR	सोम प्रसाद गैरे	29	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	52
1478	HOR	उपेन्द्र राज गहिरे	33	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	52
1479	HOR	केशर वहादुर आले	37	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	52
1480	HOR	जीव लाल सुवेदी	50	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	52
1481	HOR	छविलाल विश्वकर्मा	59	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1482	HOR	तुल्सी राम धुख्वा	50	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1483	HOR	कैलाश गुरुङ्ग	56	पुरुष	Nepali	जनमत पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1484	HOR	विशाल वास्कोटा	29	पुरुष	Nepali	हाम्रो नेपाली पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1485	HOR	धनीराम चौधरी	53	पुरुष	Nepali	नागरिक उन्मुक्ति पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1486	HOR	राकेश बनियाँ	35	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1487	HOR	शिव बहादुर गुरुङ्ग	57	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1488	HOR	दल बहादुर थापा	44	पुरुष	Nepali	राष्ट्रिय जनमुक्ति पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1489	HOR	नरेश बहादुर पछाई क्षेत्री	47	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1490	HOR	टीकाराम जैसी चापागाई	52	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1491	HOR	दुर्गा पाण्डे	32	महिला	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1492	HOR	धनराज भुर्तेल	35	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1493	HOR	टिका मणी पुन	57	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1494	HOR	कमल पाण्डे	49	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1495	HOR	घनश्याम भुसाल	61	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1496	HOR	लिलामणि न्‍यौपाने	30	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1497	HOR	लक्ष्मण भण्डारी	27	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1498	HOR	कमल नाथ भुसाल	48	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1499	HOR	दिपक शर्मा	41	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1500	HOR	बिष्णु प्रसाद चौधरी कुर्मी	74	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1501	HOR	मातृका प्रसाद यादव	63	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1502	HOR	विष्‍णु प्रसाद पौडेल	62	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1503	HOR	हरि सुन्दर बासी	41	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1504	HOR	दिपक थापा	38	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1505	HOR	केशव बहादुर थापा मगर	52	पुरुष	Nepali	राष्ट्रिय जनमुक्ति पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1506	HOR	नमा देबी गौतम जैसी	48	महिला	Nepali	नेपाली कांग्रेस (बी.पी.)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1507	HOR	राजु शाही	43	पुरुष	Nepali	नेपाल दलित पार्टी(एकल चुनाव चिन्ह)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1508	HOR	गणेश पौडेल	27	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1509	HOR	सुरेन्द्र भारी	38	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1510	HOR	टोप नारायण पौडेल	45	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1511	HOR	रुप सिंह थापा	62	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1512	HOR	केशब बस्याल	30	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1513	HOR	विष्णु विश्‍वकर्मा	45	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1514	HOR	तुलसी  राम यादव	26	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1515	HOR	तारा घिमिरे	40	महिला	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1516	HOR	प्रदिप ज्ञवाली	39	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1517	HOR	बाल कृष्ण खाँण	62	पुरुष	Nepali	नेपाली काँग्रेस	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1518	HOR	दीपक बोहरा	71	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1519	HOR	सरु वि. क.	34	महिला	Nepali	नेपाल मजदुर किसान पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1520	HOR	प्रमोद कुमार राउत	43	पुरुष	Nepali	जनमत पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1521	HOR	प्रख्यात वन्जाडे	47	पुरुष	Nepali	हाम्रो नेपाली पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1522	HOR	तुल्‍सी प्रसाद थारु	37	पुरुष	Nepali	नागरिक उन्मुक्ति पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1523	HOR	सरस्वती धोवी धवल	43	महिला	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी नेपाल	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1524	HOR	तेज कुमारी आले	42	महिला	Nepali	मंगोल नेशनल अर्गनाइजेसन	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1525	HOR	लाल वहादुर राना	38	पुरुष	Nepali	गान्धीवादी पार्टी नेपाल	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1526	HOR	मोजीब अलि मुसलमान	38	पुरुष	Nepali	राष्ट्रिय जनमुक्ति पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1527	HOR	जित बहादुर गुप्‍ता तेली	40	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1528	HOR	राजिव शाही	36	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1529	HOR	गुडिया पथरकट्ट	45	महिला	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1530	HOR	देव राज न्‍यौपाने	49	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1531	HOR	नबाब मुसलमान	40	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1532	HOR	नारायण प्रसाद शर्मा	53	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1533	HOR	केशव विक्रम खडका	60	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1534	HOR	इशरात अली फकीर	32	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1535	HOR	घनश्याम भट्टराई	41	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1536	HOR	जिव कान्त काफले	45	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1537	HOR	नरेश  बहादुर  क्षेत्री	26	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1539	HOR	प्रमोद कुमार यादव	43	पुरुष	Nepali	नेपाली काँग्रेस	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1540	HOR	ओम प्रकाश यादव	42	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1541	HOR	सर्वेन्द्र नाथ शुक्ला	72	पुरुष	Nepali	लोकतान्त्रिक समाजवादी पार्टी, नेपाल	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1542	HOR	भोपेन्द्र प्रसाद यादव	37	पुरुष	Nepali	जनमत पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1543	HOR	सत्य देव चौधरी	42	पुरुष	Nepali	नागरिक उन्मुक्ति पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1544	HOR	खिल बहादुर गाहा	51	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1545	HOR	जौहर अली जोलहा	50	पुरुष	Nepali	राष्ट्रिय जनमुक्ति पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1546	HOR	महेन्द्र नाथ सि‌ह राय	46	पुरुष	Nepali	नेपाल जनता पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1547	HOR	अनूप कुमार यादव	38	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1548	HOR	अब्दुल जुबेर मुसलमान	69	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1549	HOR	जवाहर प्रसाद गडेरिया	66	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1550	HOR	दिलीप बरई	31	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1551	HOR	दिलिप कुमार यादव	38	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1552	HOR	बासु देव घिमिरे	54	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1553	HOR	भरत कुमार शाह	68	पुरुष	Nepali	नेपाली काँग्रेस	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1554	HOR	हिम लाल पाण्‍डे	34	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1555	HOR	चन्द्रशेखर सोनार	38	पुरुष	Nepali	जनमत पार्टी	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1556	HOR	भिष्म कुमार राना	46	पुरुष	Nepali	हाम्रो नेपाली पार्टी	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1557	HOR	पम्फा सिंजाली	36	महिला	Nepali	मंगोल नेशनल अर्गनाइजेसन	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1558	HOR	भैर बहादुर थापा मगर	57	पुरुष	Nepali	राष्ट्रिय जनमुक्ति पार्टी	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1559	HOR	कृष्ण उपाध्या	56	पुरुष	Nepali	जनसमाजवादी पार्टी नेपाल	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1560	HOR	शब्बीर अहमद खाँ	59	पुरुष	Nepali	स्वतन्त्र	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1561	HOR	गोविन्द प्रसाद पाण्डेय	65	पुरुष	Nepali	स्वतन्त्र	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1562	HOR	अव्वु हरेरा मुसलमान	56	पुरुष	Nepali	स्वतन्त्र	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1563	HOR	भानुभक्त भण्डारी	56	पुरुष	Nepali	स्वतन्त्र	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1564	HOR	केशव राज पौडेल	37	पुरुष	Nepali	स्वतन्त्र	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1565	HOR	अब्दुल लजीम मुसलमान	55	पुरुष	Nepali	स्वतन्त्र	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1566	HOR	कलिमुल्लाह मुसलमान	47	पुरुष	Nepali	स्वतन्त्र	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1567	HOR	राम प्रसाद घिमिरे	54	पुरुष	Nepali	स्वतन्त्र	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1568	HOR	सन्नी खान	29	पुरुष	Nepali	स्वतन्त्र	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	49
1569	HOR	बलराम अधिकारी	62	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1570	HOR	चक्रपाणी खनाल	60	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (माओवादी केन्द्र)(एकल चुनाव चिन्ह)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1571	HOR	ध्रुव बहादुर रायमाझी	47	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1572	HOR	यम लाल चौधरी	37	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1708	HOR	सोहराव पठान	61	पुरुष	Nepali	जनमत पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	58
1573	HOR	रबीन्द्र नाथ मिश्र	64	पुरुष	Nepali	लोकतान्त्रिक समाजवादी पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1574	HOR	नरेन्‍द्र प्रसाद चौधरी	52	पुरुष	Nepali	जनमत पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1575	HOR	देवेन्द्र कुमार शर्मा	26	पुरुष	Nepali	हाम्रो नेपाली पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1576	HOR	श्रवण कुमार उपाध्‍याय	39	पुरुष	Nepali	जनता प्रगतिशिल पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1577	HOR	राम मिलन थारु	53	पुरुष	Nepali	नागरिक उन्मुक्ति पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1578	HOR	राम नरेश कलवार	36	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1579	HOR	युवराज शर्मा आचार्य	75	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (मार्क्सवादी लेनिनवादी)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1580	HOR	उत्तम सिंह  राना	51	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1581	HOR	उत्तम आले	43	पुरुष	Nepali	राष्ट्रिय जनमुक्ति पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1582	HOR	तपेसरी कहार	64	पुरुष	Nepali	बहुजन शक्ति पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1583	HOR	बसन्त पोख्रेल	38	पुरुष	Nepali	एकीकृत शक्ति नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1584	HOR	बीर बहादुर चौधरी	30	पुरुष	Nepali	नेपाल संघीय समाजवादी पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1585	HOR	सन्‍जू सिंह विष्‍ट	48	महिला	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1586	HOR	शेर बहादुर यादव	35	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1587	HOR	गिता देवी पौडेल	44	महिला	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1588	HOR	योगेश क्षेत्री	30	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1589	HOR	ललित गुरुङ	62	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1590	HOR	बृजेश कुमार गुप्‍त	51	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1591	HOR	सुरेन्द्र राज आचार्य	64	पुरुष	Nepali	नेपाली काँग्रेस	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1592	HOR	सविता शर्मा	30	महिला	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1593	HOR	अकबाल अहमद शाह	62	पुरुष	Nepali	लोकतान्त्रिक समाजवादी पार्टी, नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1594	HOR	विश्वनाथ यादव	51	पुरुष	Nepali	नेपालका लागि नेपाली पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1595	HOR	सुर्य वहादुर थापा	77	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1596	HOR	जितेन्द्र पान्डेय	29	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1597	HOR	विजय नन्द चौवे	59	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1598	HOR	सकिल मोहम‍्मद फकिर	38	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1599	HOR	प्रहलाद प्रसाद कहाँर	45	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1600	HOR	कृष्ण आचार्य	29	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1601	HOR	मंगल प्रसाद गुप्‍ता	77	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1602	HOR	अभिषेक प्रताप शाह	40	पुरुष	Nepali	नेपाली काँग्रेस	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1603	HOR	प्रकाश रजौरिया	49	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1604	HOR	नरसिहं चौधरी	70	पुरुष	Nepali	जनमत पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1605	HOR	यम नाथ उपाध्याय	32	पुरुष	Nepali	मौलिक जरोकिलो पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1606	HOR	ईश्वर दयाल मिश्र	56	पुरुष	Nepali	जनता प्रगतिशिल पार्टी, नेपाल	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1607	HOR	केश बहादुर थापा	79	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1608	HOR	गीता शुक्‍ला	58	महिला	Nepali	नेपाल जनता पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1609	HOR	राम चन्द्र कोरी	45	पुरुष	Nepali	बहुजन शक्ति पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1610	HOR	दिपक बेल्वसे	29	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1611	HOR	परमेश्‍वर दयाल मिश्र	49	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1612	HOR	कृष्ण कुमार उपाध्याय	42	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1613	HOR	धर्म किशोर मुराउ मौर्य	45	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1614	HOR	गणेश कुमार जि सी	57	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1615	HOR	मनी राम कोहार	50	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1616	HOR	बिनोद कुमार कोरी	47	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1617	HOR	बालाजी चौधरी कुर्मी	55	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1618	HOR	आरती रजौरिया भुसाल	38	महिला	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	47
1619	HOR	पूर्ण बुढामगर	36	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	55
1620	HOR	बर्षमान पुन	51	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (माओवादी केन्द्र)(एकल चुनाव चिन्ह)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	55
1621	HOR	लीला रावल	38	महिला	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	55
1622	HOR	नाती भाइ ह्‍योम्बा	56	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	55
1623	HOR	राम बहादुर वली क्षेत्री	64	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	55
1624	HOR	शान्ता चौधरी	43	महिला	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	53
1625	HOR	लिली वुढाथोकी	49	महिला	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	53
1626	HOR	गणेश भक्त खर्बुजा	56	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	53
1627	HOR	प्रतिमा बुढा मगर	30	महिला	Nepali	लोकतान्त्रिक समाजवादी पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	53
1628	HOR	मेटमणि चौधरी	49	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एकिकृत समाजबादी)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	53
1629	HOR	गंगा चौधरी(सत्गौवा)	43	महिला	Nepali	हाम्रो नेपाली पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	53
1630	HOR	सुरेन्द्र चौधरी	50	पुरुष	Nepali	नागरिक उन्मुक्ति पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	53
1631	HOR	शोभाराम बुढा	70	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	53
1632	HOR	अशोक खड्का	44	पुरुष	Nepali	नेपाली कांग्रेस (बी.पी.)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	53
1633	HOR	रुक्मिणि चौधरी (थारु)	45	महिला	Nepali	संघीय लोकतान्त्रिक राष्ट्रिय मञ्च(थरुहट)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	53
1634	HOR	देवराज पाठक	56	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	53
1635	HOR	चन्द्रमणी न्यौपाने	46	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	53
1636	HOR	शंकर पोख्रेल	59	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	53
1637	HOR	रेखा शर्मा	53	महिला	Nepali	नेपाल कम्युनिष्ट पार्टी (माओवादी केन्द्र)(एकल चुनाव चिन्ह)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	53
1638	HOR	भोलानाथ योगी	61	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	53
1639	HOR	आसा राम वैद्य	55	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	53
1640	HOR	रामचन्द्र खड्का	36	पुरुष	Nepali	मौलिक जरोकिलो पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	53
1641	HOR	शसीराम चौधरी	47	पुरुष	Nepali	हाम्रो नेपाली पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	53
1642	HOR	रेशम  चौधरी	41	पुरुष	Nepali	नागरिक उन्मुक्ति पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	53
1643	HOR	नेत्र प्रसाद पाण्डेय	37	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (मार्क्सवादी लेनिनवादी)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	53
1644	HOR	खडक बहादुर बुढा मगर	59	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	53
1645	HOR	गोविन्द प्रसाद शर्मा	64	पुरुष	Nepali	नेपाली कांग्रेस (बी.पी.)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	53
1646	HOR	गीता रावत	46	महिला	Nepali	नेपाल आमा पार्टी(एकल चुनाव चिन्ह)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	53
1647	HOR	बिशाल अधिकारी	29	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	53
1648	HOR	यमलाल जि.सी.	43	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	53
1649	HOR	भुपनाथ अर्जेल	42	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	53
1650	HOR	कृष्ण बहादुर डाँगी	49	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	53
1651	HOR	कोमल वली	53	महिला	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	53
1652	HOR	दिपक गिरी	60	पुरुष	Nepali	नेपाली काँग्रेस	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	53
1653	HOR	देवि लाल डाँगी	40	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	53
1654	HOR	ओज बहादुर खड्का	63	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	53
1655	HOR	वीर बहादुर चौधरी	34	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	53
1656	HOR	कुमार चौधरी	30	पुरुष	Nepali	नागरिक उन्मुक्ति पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	53
1657	HOR	शालिकराम चौधरी	52	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (मार्क्सवादी लेनिनवादी)	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	53
1658	HOR	घनश्याम चौधरी	41	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	53
1659	HOR	कृष्णविर नेपाली	67	पुरुष	Nepali	राष्ट्रिय जनमुक्ति पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	53
1660	HOR	कमल सुबेदी	35	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	53
1661	HOR	हेमन्त बहादुर मल्ल	56	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	53
1662	HOR	तिलक खड्का	38	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	53
1663	HOR	लिलाधर न्यौपाने	49	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	53
1664	HOR	घन श्‍याम डांगी	36	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	53
1665	HOR	टोपेन्द्र बस्नेत	35	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	53
1666	HOR	भुप बहादुर भण्डारी	54	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	53
1667	HOR	सुर्य प्रसाद ढकाल	50	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	57
1668	HOR	महेश्‍वर जंग गहतराज (अथक)	51	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (माओवादी केन्द्र)(एकल चुनाव चिन्ह)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	57
1669	HOR	राम कुमार यादव	56	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	57
1670	HOR	नवीन कुमार शाही	46	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	57
1671	HOR	राम चरण चौधरी	39	पुरुष	Nepali	लोकतान्त्रिक समाजवादी पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	57
1672	HOR	उब्जङ शाही	49	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी माओवादी समाजवादी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	57
1673	HOR	सुरेश कुमार चौधरी	53	पुरुष	Nepali	नागरिक उन्मुक्ति पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	57
1674	HOR	भक्त बहादुर थापा मगर	66	पुरुष	Nepali	नेपालका लागि नेपाली पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	57
1675	HOR	कुन्ती शर्मा	32	महिला	Nepali	नेपाली कांग्रेस (बी.पी.)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	57
1676	HOR	आनन्द बाबु काफ्ले	42	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	57
1677	HOR	प्रदिप कुमार शाह	60	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	57
1678	HOR	सुदीप नरसिंह राणा	58	पुरुष	Nepali	नेपाली काँग्रेस	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	57
1679	HOR	मोहम्मद इश्तियाक राई	42	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	57
1680	HOR	धवलशम्मशेर जगंबहादुर राणा	61	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	57
1681	HOR	वखत बहादुर थापा	46	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	57
1682	HOR	अव्दुल हन्नान जसगढ	42	पुरुष	Nepali	लोकतान्त्रिक समाजवादी पार्टी, नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	57
1683	HOR	बाबु खाँ	61	पुरुष	Nepali	जनमत पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	57
1684	HOR	रमेश शर्मा अर्याल	64	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	57
1685	HOR	बिधा शर्मा	43	महिला	Nepali	राष्ट्रिय जनमुक्ति पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	57
1686	HOR	खलु प्रसाद थारु	74	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी मार्क्सवादी (पुष्पलाल)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	57
1687	HOR	लिलौ दर्जी	73	पुरुष	Nepali	जनसमाजवादी पार्टी नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	57
1688	HOR	बिनोद कुमार अग्रहरी	48	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	57
1689	HOR	दिवाकर खनाल	64	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	57
1690	HOR	बागेश्‍वर चौलागाई	33	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	57
1691	HOR	राहुल जयसवाल	27	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	57
1692	HOR	इरफान अहमद शेख	37	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	57
1693	HOR	समसुल हक राई	42	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	57
1694	HOR	किस्मत कुमार कक्षपति	62	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	57
1695	HOR	किशोर सिह राठोर	53	पुरुष	Nepali	नेपाली काँग्रेस	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	57
1696	HOR	नोयन्द्र धिताल	31	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	57
1697	HOR	नगेन्द्र बहादुर बुढाक्षेत्री	36	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	57
1698	HOR	हफिज पठान	68	पुरुष	Nepali	लोकतान्त्रिक समाजवादी पार्टी, नेपाल	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	57
1699	HOR	राजु प्रसाद कुर्मी	38	पुरुष	Nepali	जनमत पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	57
1700	HOR	वीर बहादुर ओली क्षेत्री	62	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी मार्क्सवादी (पुष्पलाल)	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	57
1701	HOR	दुर्गा बहादुर घिमिरे	73	पुरुष	Nepali	नेपाली कांग्रेस (बी.पी.)	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	57
1702	HOR	देवेन्द्र नाथ शुक्ला	57	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	57
1703	HOR	लक्ष्मणराज ज्ञवाली	62	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	58
1704	HOR	संजय कुमार गौतम	59	पुरुष	Nepali	नेपाली काँग्रेस	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	58
1705	HOR	रेशम बहादुर खत्री	59	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	58
1706	HOR	सूर्य बहादुर सिंह	52	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	58
1707	HOR	हरिलाल न्यौपाने	69	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	58
1709	HOR	ठाकुर सिंह थारु	48	पुरुष	Nepali	नागरिक उन्मुक्ति पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	58
1710	HOR	रामरतन थारु	46	पुरुष	Nepali	नेश्नलिष्ट पिपल्स पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	58
1711	HOR	प्रवेश भुसाल	29	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	58
1712	HOR	देवी प्रसाद तिवारी	38	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	58
1713	HOR	पंकज सिंह राठौर	55	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	58
1714	HOR	सुरेश पन्थ	46	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (माओवादी केन्द्र)(एकल चुनाव चिन्ह)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	58
1715	HOR	विनय रावल	45	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	58
1716	HOR	धर्म राज जैसी आचार्य	48	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	58
1717	HOR	अनिरुध्या आर्य	44	पुरुष	Nepali	लोकतान्त्रिक समाजवादी पार्टी, नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	58
1718	HOR	ओम  प्रकाश बसौला	37	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	58
1719	HOR	राम प्रसाद आचार्य	25	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	58
1720	HOR	लालविर चौधरी	67	पुरुष	Nepali	स्वतन्त्र	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	58
1721	HOR	राजेन्द्र वीर राय	63	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	60
1722	HOR	नेत्रलाल श्रेष्ठ	66	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	60
1723	HOR	प्रकाश ज्वाला	55	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एकिकृत समाजबादी)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	60
1724	HOR	भिम बहादुर वली	47	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (मार्क्सवादी लेनिनवादी)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	60
1725	HOR	पवन राज देवकोटा	42	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	60
1726	HOR	राजेन्द्र बहादुर शाह	70	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	60
1727	HOR	जुद्ध बहादुर सिंह	26	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	60
1728	HOR	गणेश बहादुर शाही	49	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	61
1729	HOR	अंगद कुमार बुढा	50	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	61
1730	HOR	धन बहादुर बुढा	47	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एकिकृत समाजबादी)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	61
1731	HOR	हर्क बहादुर ठकुल्ला	63	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी मार्क्सवादी (पुष्पलाल)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	61
1732	HOR	विर बहादुर रोकाया	52	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	61
1733	HOR	राज बहादुर कार्की	43	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	65
1734	HOR	ऐन बहादुर शाही ठकुरी	52	पुरुष	Nepali	नेपाली काँग्रेस	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	65
1735	HOR	राज बहादुर मल्ल	54	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	65
1736	HOR	कृष्‍ण बहादुर सेजुवाल	55	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	65
1737	HOR	भीम चन्द्र हमाल	72	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	65
1738	HOR	रतन नाथ योगी	44	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	63
1739	HOR	गोमा गौतम (कुँवर)	39	महिला	Nepali	नेपाल कम्युनिष्ट पार्टी (माओवादी केन्द्र)(एकल चुनाव चिन्ह)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	63
1740	HOR	ज्ञान बहादुर शाही	30	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	63
1741	HOR	डिल्ली प्रसाद काफ्ले	61	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	63
1742	HOR	डा.कल बहादुर रोकाया	57	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	63
1743	HOR	श्री नगीन्द्र शाही	43	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	64
1744	HOR	महेन्द्र बहादुर शाही	45	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (माओवादी केन्द्र)(एकल चुनाव चिन्ह)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	64
1745	HOR	धन बहादुर बुढा	48	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	64
1746	HOR	खड्ग राज शाही	35	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	64
1747	HOR	पंख बहादुर विष्ट	62	पुरुष	Nepali	नेपाली कांग्रेस (बी.पी.)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	64
1748	HOR	काशी चन्द्र बराल	50	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	64
1749	HOR	धन प्रसाद पाण्डे	59	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	64
1750	HOR	दल रावल	51	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	62
1751	HOR	छिरिङ डम्डुल लामा (भोटे)	55	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (माओवादी केन्द्र)(एकल चुनाव चिन्ह)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	62
1752	HOR	तेज बहादुर रावत	28	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	62
1753	HOR	निरज प्रसाद आचार्य	45	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	68
1754	HOR	शक्ति बहादुर वस्नेत	53	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (माओवादी केन्द्र)(एकल चुनाव चिन्ह)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	68
1755	HOR	दिपक खनाल	50	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	68
1756	HOR	झलक नाथ वाग्ले	64	पुरुष	Nepali	नेपाली कांग्रेस (बी.पी.)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	68
1757	HOR	राज वहादुर शाही	40	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	68
1758	HOR	नर बहादुर कार्की	49	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	68
1759	HOR	रविन्द्र राज शर्मा	58	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	67
1760	HOR	कुन्ती कुमारी शाही	45	महिला	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	67
1761	HOR	प्रकाश गुरुङ्ग	30	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	67
1762	HOR	अम्मर बहादुर थापा	66	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एकिकृत समाजबादी)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	67
1763	HOR	भूपाल वहादुर थापा	63	पुरुष	Nepali	नेपाली कांग्रेस (बी.पी.)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	67
1764	HOR	ईन्द्र प्रसाद शर्मा	41	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	67
1765	HOR	निरख वहादुर थापा	65	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	67
1766	HOR	गोपाल नेपाली	58	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	67
1767	HOR	लक्ष्मी प्रसाद पोखरेल	60	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	67
1768	HOR	दिक्पाल कुमार शाहि	61	पुरुष	Nepali	नेपाली काँग्रेस	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	67
1769	HOR	लोकेन्द्रराज गिरी	33	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	67
1770	HOR	केसेन्द्र प्रकाश कार्की	63	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	67
1771	HOR	बखत बहादुर भण्डारी	52	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	67
1772	HOR	ध्रुवकुमार शाही	52	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	66
1773	HOR	पूर्ण बहादुर खड्का	66	पुरुष	Nepali	नेपाली काँग्रेस	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	66
1774	HOR	कर्ण बहादुर थापा	61	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	66
1775	HOR	छत्रपति थापा क्षेत्री	67	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	66
1776	HOR	प्रेम कुमार थापा	46	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	66
1777	HOR	जिवन चन्द	33	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	66
1778	HOR	शेर वहादुर घर्तीमगर	48	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	66
1779	HOR	मोहम्मद हसरत अली	32	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	66
1780	HOR	अमृत बहादुर बुढा क्षेत्री	63	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	66
1781	HOR	हृदयराम थानी	62	पुरुष	Nepali	नेपाली काँग्रेस	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	66
1782	HOR	दिप बहादुर नेपाली	60	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	66
1783	HOR	भिम बहादुर शाही	39	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	66
1784	HOR	तुल्छी खडका	39	महिला	Nepali	नेपाल मजदुर किसान पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	66
1785	HOR	टेक्मल दमाई	45	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी माओवादी समाजवादी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	66
1786	HOR	वीरेन्द्रा कुमारी चन्द	45	महिला	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	66
1787	HOR	कुमारी राई	41	महिला	Nepali	नेश्नलिष्ट पिपल्स पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	66
1788	HOR	टेक बहादुर चुनारा	44	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	66
1789	HOR	नन्दराम देवकोटा	50	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	59
1790	HOR	जनार्दन शर्मा	59	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (माओवादी केन्द्र)(एकल चुनाव चिन्ह)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	59
1791	HOR	दिपक कुमार मल्ल	55	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	59
1792	HOR	हरी बहादुर पुन	45	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	59
1793	HOR	तारक के.सी.	33	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	59
1794	HOR	राजन पाण्डे	26	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	59
1795	HOR	कर्ण बहादुर थापा	54	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	71
1796	HOR	बद्री प्रसाद पाण्डे	48	पुरुष	Nepali	नेपाली काँग्रेस	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	71
1797	HOR	जंग कुमार गिरी	46	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	71
1798	HOR	राम बहादुर शाही	45	पुरुष	Nepali	जनसमाजवादी पार्टी नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	71
1799	HOR	टेक बहादुर बडुवाल	39	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	71
1800	HOR	गौरी कुमारी ओली	49	महिला	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	73
1801	HOR	अंक बहादुर खड्का	65	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	73
1802	HOR	प्रेम वहादुर आले	51	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एकिकृत समाजबादी)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	73
1803	HOR	केशव वलायर	27	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	73
1804	HOR	राज प्रशाद जोशी	68	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	73
1805	HOR	नरेन्द्र बहादुर खडका	50	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	73
1806	HOR	तपेन्द्र बहादुर रावल	49	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1807	HOR	राम जनम चौधरी	62	पुरुष	Nepali	नेपाली काँग्रेस	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1808	HOR	लोकेन्‍द्र कुँवर	33	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1809	HOR	धन बहादुर मगर	70	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1810	HOR	रन्जिता श्रेष्ठ	39	महिला	Nepali	नागरिक उन्मुक्ति पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1811	HOR	मान बहादुर चौधरी	40	पुरुष	Nepali	नेपालका लागि नेपाली पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1812	HOR	भोज बहादुर विश्वकर्मा	44	पुरुष	Nepali	संघीय लोकतान्त्रिक राष्ट्रिय मञ्च	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1813	HOR	तिलक बहादुर शाही	69	पुरुष	Nepali	राष्ट्रिय जनमुक्ति पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1814	HOR	टंक प्रसाद जैशी(ढुंगाना)	41	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1815	HOR	विजयराज सिंह मयाल	44	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1816	HOR	ललित बहादुर थापा	40	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1817	HOR	झपट बहादुर रावल	47	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1818	HOR	भगत बहादुर बढुवाल	50	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (माओवादी केन्द्र)(एकल चुनाव चिन्ह)	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1819	HOR	भरत सिहं वि.सि.(बुढाक्षेत्री)	42	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1820	HOR	रमेश कुमार रावल	45	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1821	HOR	कमलेश कुमार चौधरी	33	पुरुष	Nepali	लोकतान्त्रिक समाजवादी पार्टी, नेपाल	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1822	HOR	शेखर शर्मा	50	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी माओवादी समाजवादी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1823	HOR	अरुन कुमार चौधरी	37	पुरुष	Nepali	नागरिक उन्मुक्ति पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1824	HOR	पदम बहादुर वुढामगर	25	पुरुष	Nepali	मंगोल नेशनल अर्गनाइजेसन	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1825	HOR	देशराम चौधरी	45	पुरुष	Nepali	नेपाल लोकतान्त्रिक पार्टी	2	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1826	HOR	गौरी शंकर चौधरी	40	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1827	HOR	कृष्ण कुमार चौधरी	44	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (माओवादी केन्द्र)(एकल चुनाव चिन्ह)	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1828	HOR	बिरेन्द्र बहादुर बम	50	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1829	HOR	गंगा देबी पौडेल	37	महिला	Nepali	नेपाल मजदुर किसान पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1830	HOR	गंगा राम चौधरी	44	पुरुष	Nepali	नागरिक उन्मुक्ति पार्टी	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1831	HOR	परेक बहादुर रावल	54	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (मार्क्सवादी लेनिनवादी)	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1832	HOR	नवीन कुमार बोहरा	34	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1833	HOR	रमेश आचार्य	37	पुरुष	Nepali	स्वतन्त्र	3	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1834	HOR	लेख राज भट्ट	63	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1835	HOR	विर बहादुर बलायर	57	पुरुष	Nepali	नेपाली काँग्रेस	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1836	HOR	जय बहादुर धामी	36	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1837	HOR	सिताराम पण्डिल	30	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1838	HOR	चेत राज साउँद	45	पुरुष	Nepali	मौलिक जरोकिलो पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1839	HOR	मोहन देव मिश्र	41	पुरुष	Nepali	जनता प्रगतिशिल पार्टी, नेपाल	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1840	HOR	कइयाँ चौधरी	64	पुरुष	Nepali	नागरिक उन्मुक्ति पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1841	HOR	भिम बहादुर थापामगर	47	पुरुष	Nepali	नेपाल संघीय समाजवादी पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1842	HOR	गोविन्द प्रसाद भट्ट	46	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1843	HOR	मेख राज जोशी	46	पुरुष	Nepali	स्वतन्त्र	4	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1844	HOR	नारद मुनि राना	50	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1845	HOR	डिल्ली राज पन्त	66	पुरुष	Nepali	नेपाली काँग्रेस	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1846	HOR	नन्दा कुमारी दर्लामीमगर (राना)	37	महिला	Nepali	नेपाल मजदुर किसान पार्टी	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1847	HOR	दान बहादुर विश्‍‍वकर्मा	68	पुरुष	Nepali	लोकतान्त्रिक समाजवादी पार्टी, नेपाल	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1848	HOR	इश्वरी विष्ट	38	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1849	HOR	जगदीश चौधरी	57	पुरुष	Nepali	स्वतन्त्र	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1850	HOR	सत्य राज उपाध्याय	30	पुरुष	Nepali	स्वतन्त्र	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1851	HOR	राम बहादुर सिंह	27	पुरुष	Nepali	स्वतन्त्र	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1852	HOR	गगन बहादुर धामी	50	पुरुष	Nepali	स्वतन्त्र	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1853	HOR	पुष्कर नाथ ओझा	59	पुरुष	Nepali	स्वतन्त्र	5	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	77
1854	HOR	गणेश सिंह ठगुन्ना	53	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	69
1855	HOR	दिलेन्द्र प्रसाद बडू	68	पुरुष	Nepali	नेपाली काँग्रेस	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	69
1856	HOR	नरेन्द्र सिंह धामी	31	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	69
1857	HOR	श्री विश्‍व राम दुवाल	53	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	69
1858	HOR	तारा दत्त जोशी	69	पुरुष	Nepali	नागरिक उन्मुक्ति पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	69
1859	HOR	देव बहादुर बम	59	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	69
1860	HOR	रमेश राम लुहार	42	पुरुष	Nepali	संघीय लोकतान्त्रिक राष्ट्रिय मञ्च	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	69
1861	HOR	धर्म सिह दयाली	45	पुरुष	Nepali	नेश्नलिष्ट पिपल्स पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	69
1862	HOR	रविन्द्र सिंह धामी	34	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	69
1863	HOR	दामोदर भण्डारी	48	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (एमाले)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	72
1864	HOR	नरेन्द्र बहादुर कुंवर	50	पुरुष	Nepali	नेपाल कम्युनिष्ट पार्टी (माओवादी केन्द्र)(एकल चुनाव चिन्ह)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	72
1865	HOR	आन सिंह भण्डारी	55	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	72
1866	HOR	देव बहादुर चन्द	49	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	72
1867	HOR	कृष्ण प्रसाद गोसाई	51	पुरुष	Nepali	नेपाल मजदुर किसान पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	72
1868	HOR	हिम्मत बहादुर चन्द	38	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	72
1869	HOR	कृष्ण बहादुर चन्द	68	पुरुष	Nepali	नेश्नलिष्ट पिपल्स पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	72
1870	HOR	प्रकाश चन्द्र भट्ट	36	पुरुष	Nepali	राष्ट्रिय स्वतन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	72
1871	HOR	त्रिलोक बहादुर चन्द	46	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	72
1872	HOR	मान सिह विष्ट	61	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	72
1873	HOR	केशव बहादुर चन्द	71	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	72
1874	HOR	शेर बहादुर देउवा	77	पुरुष	Nepali	नेपाली काँग्रेस	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	75
1875	HOR	श्याम सिनाल	43	पुरुष	Nepali	जनता समाजवादी पार्टी, नेपाल	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	75
1876	HOR	गोविन्द खडायत	42	पुरुष	Nepali	राष्ट्रिय प्रजातन्त्र पार्टी	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	75
1877	HOR	कर्ण बहादुर मल्ल	48	पुरुष	Nepali	नेपाली कांग्रेस (बी.पी.)	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	75
1878	HOR	बिक्रम बहादुर शाही	50	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	75
1879	HOR	सागर ढकाल	31	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	75
1880	HOR	कर्ण सिंह रावल	84	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	75
1881	HOR	लाल बहादुर कठायत	34	पुरुष	Nepali	स्वतन्त्र	1	ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx	\N	\N	75
\.


--
-- Data for Name: candidate_details; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.candidate_details (id, candidate_id, overall_rating, total_ratings, past_elections, social_links, created_at, updated_at) FROM stdin;
1	1	2	3	{"2000": "Mayor"}	{"facebook": "https://facebook.com/candidate1", "twitter": "https://twitter.com/candidate1"}	2025-10-08 13:32:00.460181+00	\N
2	3	0	0	{}	{}	2025-10-11 14:06:31.041055+00	\N
3	2	0	0	{}	{}	2025-10-11 14:22:46.390849+00	\N
\.


--
-- Data for Name: controversies; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.controversies (id, candidate_details_id, title, description, image_url, date, severity) FROM stdin;
1	1	Funding Dispute	Dispute over campaign funding	\N	2022-08-15 00:00:00	Medium
\.


--
-- Data for Name: country; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.country (id, name, code, created_at, updated_at) FROM stdin;
1	Nepal	NP	2025-09-30 07:05:40.110326+00	2025-09-30 07:05:40.110326+00
\.


--
-- Data for Name: district; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.district (id, province_id, name, area_sq_km, website, headquarter) FROM stdin;
1	1	Bhojpur	1507	https://www.ddcbhojpur.gov.np	Bhojpur
2	1	Dhankuta	892	https://www.ddcdhankuta.gov.np	Dhankuta
3	1	Ilam	1703	https://www.ddcilam.gov.np	Ilam
4	1	Jhapa	1606	https://www.ddcjhapa.gov.np	Bhadrapur
5	1	Khotang	1591	https://www.dcckhotang.gov.np	Diktel
6	1	Morang	1855	https://www.ddcmorang.gov.np	Biratnagar
7	1	Okhaldhunga	1074	https://www.dccokhaldhunga.gov.np/en	Siddhicharan
8	1	Pachthar	1241	https://www.ddcpanchthar.gov.np	Phidim
9	1	Sankhuwasabha	3480	https://www.ddcsankhuwasabha.gov.np	Khandbari
10	1	Solukhumbu	3312	https://www.ddcsolukhumbu.gov.np	Salleri
11	1	Sunsari	1257	https://www.ddcsunsari.gov.np	Inaruwa
12	1	Taplejung	3646	https://www.ddctaplejung.gov.np	Taplejung
13	1	Terhathum	679	https://www.ddctehrathum.gov.np	Myanglung
14	1	Udayapur	2063	https://www.ddcudayapur.gov.np	Gaighat
15	2	Parsa	1353	https://dccparsa.gov.np/	Birgunj
16	2	Bara	1190	https://dccbara.gov.np/	Kalaiya
17	2	Rautahat	1126	https://dccrautahat.gov.np/	Gaur
18	2	Sarlahi	1259	https://dccsarlahi.gov.np/	Malangawa
19	2	Siraha	1188	https://dccsiraha.gov.np/	Siraha
20	2	Dhanusha	1180	https://dccdhanusha.gov.np/	Janakpur
21	2	Saptari	1363	https://dccsaptari.gov.np/	Rajbiraj
22	2	Mahottari	1002	https://dccmahottari.gov.np/	Jaleshwar
23	3	Bhaktapur	119	https://dccbhaktapur.gov.np/	Bhaktapur
24	3	Chitwan	2218	https://dccchitwan.gov.np/	Bharatpur
25	3	Dhading	1926	https://dccdhading.gov.np/	Nilkantha
26	3	Dolakha	2191	https://dccdolakha.gov.np/	Bhimeshwar
27	3	Kathmandu	395	https://dccktm.gov.np/	Kathmandu
28	3	Kavrepalanchok	1396	https://dcckavre.gov.np/	Dhulikhel
29	3	Lalitpur	385	https://dcclalitpur.gov.np/	Lalitpur
30	3	Makwanpur	2426	https://dccmakwanpur.gov.np/	Hetauda
31	3	Nuwakot	1121	https://dccnuwakot.gov.np/	Bidur
32	3	Ramechap	1546	https://dccramechhap.gov.np/	Manthali
33	3	Rasuwa	1544	https://dccrasuwa.gov.np/	Dhunche
34	3	Sindhuli	2491	https://dccsindhuli.gov.np/	Kamalamai
35	3	Sindhupalchok	2542	https://dccsindhupalchowk.gov.np/	Chautara
36	4	Baglung	1784	https://dccbaglung.gov.np/	Baglung
37	4	Gorkha	3610	https://dccgorkha.gov.np/	Gorkha
38	4	Kaski	2017	https://dcckaski.gov.np/	Pokhara
39	4	Lamjung	1692	https://dcclamjung.gov.np/	Besisahar
40	4	Manang	2246	https://dccmanang.gov.np/	Chame
41	4	Mustang	3573	https://dccmustang.gov.np/	Jomsom
42	4	Myagdi	2297	https://dccmyagdi.gov.np/	Beni
43	4	Nawalpur	1043.1	https://dccnawalparasi.gov.np/	Kawasoti
44	4	Parwat	494	https://dccparbat.gov.np/	Kusma
45	4	Syangja	1164	https://dccsyangja.gov.np/	Putalibazar
46	4	Tanahun	1546	https://dcctanahun.gov.np/	Damauli
47	5	Kapilvastu	1738	https://dcckapilvastu.gov.np/	Taulihawa
48	5	Parasi	634.88	https://dccnawalparasi.gov.np/	Ramgram
49	5	Rupandehi	1360	https://dccrupandehi.gov.np/	Siddharthanagar
50	5	Arghakhanchi	1193	https://dccargakhanchi.gov.np/	Sandhikharka
51	5	Gulmi	1149	https://dccgulmi.gov.np/	Tamghas
52	5	Palpa	1373	https://dccpalpa.gov.np/	Tansen
53	5	Dang	2955	https://dccdang.gov.np/	Ghorahi
54	5	Pyuthan	1309	https://dccpyuthan.gov.np/	Pyuthan
55	5	Rolpa	1879	https://dccrolpa.gov.np/	Liwang
56	5	Eastern Rukum	1161.13	https://dccrukum.gov.np/	Rukumkot
57	5	Banke	2337	https://dccbanke.gov.np/	Nepalganj
58	5	Bardiya	2025	https://dccbardiya.gov.np/	Gulariya
59	6	Western Rukum	1213.49	https://dccrukum.gov.np/	Musikot
60	6	Salyan	1462	https://dccsalyan.gov.np/	Salyan
61	6	Dolpa	7889	https://dccdolpa.gov.np/	Dunai
62	6	Humla	5655	https://dcchumla.gov.np/	Simikot
63	6	Jumla	2531	https://dccjumla.gov.np/	Chandannath
64	6	Kalikot	1741	https://dcckalikot.gov.np/	Manma
65	6	Mugu	3535	https://dccmugu.gov.np/	Gamgadhi
66	6	Surkhet	2451	https://dccsurkhet.gov.np/	Birendranagar
67	6	Dailekh	1502	https://dccdailekh.gov.np/	Dailekh
68	6	Jajarkot	2230	https://dccjajarkot.gov.np/	Khalanga
69	7	Darchula	2344.61	https://ddcdarchula.gov.np/	Darchula
70	7	Bajhang	3394.21	https://dccbajhang.gov.np/	Jayaprithvi
71	7	Bajura	2300.34	https://dccbajura.gov.np/	Badimalika
72	7	Baitadi	1496.04	https://dccbaitadi.gov.np/	Dasharathchand
73	7	Doti	2295.71	https://dccdoti.gov.np/	Dipayal Silgadhi
74	7	Acham	1692	https://dccacham.gov.np/	Mangalsen
75	7	Dadeldhura	1506.09	https://dccdadeldhura.gov.np/	Amargadhi
76	7	Kanchanpur	1222.31	https://dcckanchanpur.gov.np/	Bheemdatta
77	7	Kailali	3292.35	https://dcckailali.gov.np/	Dhangadhi
\.


--
-- Data for Name: municipalities; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.municipalities (id, name, district_id, category, area_sq_km, website) FROM stdin;
1	Shadanand Municipality	1	MUNICIPALITY	241.15	http://www.shadanandamun.gov.np/
2	Bhojpur Municipality	1	MUNICIPALITY	159.51	http://www.bhojpurmun.gov.np/
3	Hatuwagadhi Rural Municipality	1	RURAL_MUNICIPALITY	142.61	http://www.hatuwagadhimun.gov.np/
4	Ramprasad Rai Rural Municipality	1	RURAL_MUNICIPALITY	158.83	http://www.ramprasadraimun.gov.np/
5	Aamchok Rural Municipality	1	RURAL_MUNICIPALITY	184.89	http://www.aamchowkmun.gov.np/
6	Tyamke Maiyum Rural Municipality	1	RURAL_MUNICIPALITY	173.41	http://www.tyamkemaiyummun.gov.np/
7	Arun Rural Municipality	1	RURAL_MUNICIPALITY	154.76	http://www.arunmun.gov.np/
8	Pauwadungma Rural Municipality	1	RURAL_MUNICIPALITY	118.86	http://www.pauwadungmamun.gov.np/
9	Salpasilichho Rural Municipality	1	RURAL_MUNICIPALITY	193.33	http://www.salpasilichhomun.gov.np/
10	Dhankuta Municipality	2	MUNICIPALITY	111	http://www.dhankutamun.gov.np/
11	Pakhribas Municipality	2	MUNICIPALITY	144.29	https://pakhribasmun.gov.np/
12	Mahalaxmi Municipality	2	MUNICIPALITY	129.39	https://mahalaxmimundhankuta.gov.np/
13	Sangurigadhi Rural Municipality	2	RURAL_MUNICIPALITY	166.44	https://sangurigadhimun.gov.np/
14	Chaubise Rural Municipality	2	RURAL_MUNICIPALITY	147.6	https://choubisemun.gov.np/
15	Sahidbhumi Rural Municipality	2	RURAL_MUNICIPALITY	99.55	https://shahidbhumimun.gov.np/
16	Chhathar Jorpati Rural Municipality	2	RURAL_MUNICIPALITY	102.83	https://chhatharjorpatimun.gov.np/
17	Suryodaya Municipality	3	MUNICIPALITY	252.52	http://www.suryodayamun.gov.np/
18	Ilam Municipality	3	MUNICIPALITY	173.32	http://www.ilammun.gov.np/
19	Deumai Municipality	3	MUNICIPALITY	191.63	http://www.deumaimun.gov.np/
20	Maijogmai Rural Municipality	3	RURAL_MUNICIPALITY	172.41	http://www.maijogmaimun.gov.np/
21	Phakphokthum Rural Municipality	3	RURAL_MUNICIPALITY	108.79	फाकफोकथुम
22	Mai Municipality	3	MUNICIPALITY	246.11	http://www.maimun.gov.np/
23	Chulachuli Rural Municipality	3	RURAL_MUNICIPALITY	108.46	http://www.chulachulimun.gov.np/
24	Rong Rural Municipality	3	RURAL_MUNICIPALITY	155.06	http://www.rongmun.gov.np/
25	Mangsebung Rural Municipality	3	RURAL_MUNICIPALITY	142.41	http://www.mansebungmun.gov.np/
26	Sandakpur Rural Municipality	3	RURAL_MUNICIPALITY	156.01	http://www.sandakpurmun.gov.np/
27	Mechinagar Municipality	4	MUNICIPALITY	192.85	http://www.mechinagarmun.gov.np/
28	Birtamod Municipality	4	MUNICIPALITY	78.24	http://www.birtamodmun.gov.np/
29	Damak Municipality	4	MUNICIPALITY	70.76	http://www.damakmun.gov.np/
30	Bhadrapur Municipality	4	MUNICIPALITY	93.35	http://www.bhadrapurmun.gov.np/
31	Shivasatakshi Municipality	4	MUNICIPALITY	145.87	http://www.shivasatakshimun.gov.np/
32	Arjundhara Municipality	4	MUNICIPALITY	109.86	http://www.arjundharamun.gov.np/
33	Gauradaha Municipality	4	MUNICIPALITY	149.86	http://www.gauradahamun.gov.np/
34	Kankai Municipality	4	MUNICIPALITY	80.98	http://www.kankaimun.gov.np/
35	Kamal Rural Municipality	4	RURAL_MUNICIPALITY	104.57	http://www.kamalmun.gov.np/
36	Buddha Shanti Rural Municipality	4	RURAL_MUNICIPALITY	79.78	http://www.buddhashantimun.gov.np/
37	Kachankawal Rural Municipality	4	RURAL_MUNICIPALITY	109.45	http://www.kachankawalmun.gov.np/
38	Jhapa Rural Municipality	4	RURAL_MUNICIPALITY	94.12	http://www.jhapamun.gov.np/
39	Barhadashi Rural Municipality	4	RURAL_MUNICIPALITY	88.44	http://www.bahradashimun.gov.np/
40	Gaurigunj Rural Municipality	4	RURAL_MUNICIPALITY	101.35	http://www.gaurigunjmun.gov.np/
41	Haldibari Rural Municipality	4	RURAL_MUNICIPALITY	117.34	http://www.haldibarimun.gov.np/
42	Diktel Rupakot Majhuwagadhi Municipality	5	MUNICIPALITY	246.51	http://www.rupakotmajhuwagadhimun.gov.np/
43	Halesi Tuwachung Municipality	5	MUNICIPALITY	280.17	http://www.halesituwachungmun.gov.np/
44	Khotehang Rural Municipality	5	RURAL_MUNICIPALITY	164.09	http://www.khotehangmun.gov.np/
45	Diprung Chuichumma Rural Municipality	5	RURAL_MUNICIPALITY	136.48	http://www.diprungmun.gov.np/
46	Aiselukharka Rural Municipality	5	RURAL_MUNICIPALITY	125.93	http://www.aiselukharkamun.gov.np/
47	Jantedhunga Rural Municipality	5	RURAL_MUNICIPALITY	128.62	http://www.jantedhungamun.gov.np/
48	Kepilasgadhi Rural Municipality	5	RURAL_MUNICIPALITY	191.28	http://www.kepilasgadhimun.gov.np/
49	Barahpokhari Rural Municipality	5	RURAL_MUNICIPALITY	141.6	http://www.barahapokharimun.gov.np/
50	Rawa Besi Rural Municipality	5	RURAL_MUNICIPALITY	97.44	http://www.lamidandamun.gov.np/
51	Sakela Rural Municipality	5	RURAL_MUNICIPALITY	79.99	http://www.sakelamun.gov.np/
52	Sundar Haraicha Municipality	6	MUNICIPALITY	110.16	http://www.sundarharaichamun.gov.np/
53	Belbari Municipality	6	MUNICIPALITY	132.79	http://www.belbarimun.gov.np/
54	Pathari Shanischare Municipality	6	MUNICIPALITY	79.81	http://www.patharishanishcharemun.gov.np/
55	Ratuwamai Municipality	6	MUNICIPALITY	142.15	http://www.ratuwamaimun.gov.np/
56	Urlabari Municipality	6	MUNICIPALITY	74.62	http://www.urlabarimun.gov.np/
57	Rangeli Municipality	6	MUNICIPALITY	111.78	http://www.rangelimun.gov.np/
58	Sunawarshi Municipality	6	MUNICIPALITY	106.4	http://www.sunawarshimun.gov.np/
59	Letang Municipality	6	MUNICIPALITY	119.23	http://www.letangmun.gov.np/
60	Biratnagar Metropolitan City	6	METROPOLITAN	77	http://www.biratnagarmun.gov.np/
61	Jahada Rural Municipality	6	RURAL_MUNICIPALITY	62.38	http://www.jahadamun.gov.np/
62	Budi Ganga Rural Municipality	6	RURAL_MUNICIPALITY	56.41	https://budhigangamunmorang.gov.np/
63	Katahari Rural Municipality	6	RURAL_MUNICIPALITY	51.59	http://www.kataharimun.gov.np/
64	Dhanpalthan Rural Municipality	6	RURAL_MUNICIPALITY	70.26	http://www.dhanapalthanmun.gov.np/
65	Kanepokhari Rural Municipality	6	RURAL_MUNICIPALITY	82.83	http://www.kanepokharimun.gov.np/
66	Gramthan Rural Municipality	6	RURAL_MUNICIPALITY	71.84	http://www.gramthanmun.gov.np/
67	Kerabari Rural Municipality	6	RURAL_MUNICIPALITY	219.83	http://www.kerabarimun.gov.np/
68	Miklajung Rural Municipality	6	RURAL_MUNICIPALITY	157.98	http://www.miklajungmunmorang.gov.np/
69	Siddhicharan Municipality	7	MUNICIPALITY	167.88	http://www.siddhicharanmun.gov.np/
70	Khiji Demba Rural Municipality	7	RURAL_MUNICIPALITY	179.77	http://www.khijidembamun.gov.np/
71	Chisankhugadhi Rural Municipality	7	RURAL_MUNICIPALITY	126.91	http://www.chishankhugadhimun.gov.np/
72	Molung Rural Municipality	7	RURAL_MUNICIPALITY	112	http://www.molungmun.gov.np/
73	Sunkoshi Rural Municipality	7	RURAL_MUNICIPALITY	143.75	http://www.sunkoshimunokhaldhunga.gov.np/
74	Champadevi Rural Municipality	7	RURAL_MUNICIPALITY	126.91	http://www.champadevimun.gov.np/
75	Manebhanjyang Rural Municipality	7	RURAL_MUNICIPALITY	146.61	http://www.manebhanjyangmun.gov.np/
76	Likhu Rural Municipality	7	RURAL_MUNICIPALITY	88.03	https://likhumunokhaldhunga.gov.np/
77	Phidim Municipality	8	MUNICIPALITY	192.5	http://www.phidimmun.gov.np/
78	Miklajung Rural Municipality	8	RURAL_MUNICIPALITY	166.61	http://www.miklajungmunpanchthar.gov.np/
79	Phalgunanda Rural Municipality	8	RURAL_MUNICIPALITY	107.53	http://www.phalgunandamun.gov.np/
80	Hilihang Rural Municipality	8	RURAL_MUNICIPALITY	123.01	http://www.hilihangmun.gov.np/
81	Phalelung Rural Municipality	8	RURAL_MUNICIPALITY	207.14	http://www.phalelungmun.gov.np/
82	Yangwarak Rural Municipality	8	RURAL_MUNICIPALITY	208.63	http://www.yangwarakmunpanchthar.gov.np/
83	Kummayak Rural Municipality	8	RURAL_MUNICIPALITY	129.3	http://www.kummayakmun.gov.np/
84	Tumbewa Rural Municipality	8	RURAL_MUNICIPALITY	117.34	http://www.tumwewamun.gov.np/
85	Khandbari Municipality	9	MUNICIPALITY	122.78	http://www.khandbarimun.gov.np/
86	Chainpur Municipality	9	MUNICIPALITY	223.69	http://www.chainpurmun.gov.np/
87	Dharmadevi Municipality	9	MUNICIPALITY	132.82	http://www.dharmadevimun.gov.np/
88	Panchkhapan Municipality	9	MUNICIPALITY	148.03	http://www.panchkhapanmun.gov.np/
89	Madi Municipality	9	MUNICIPALITY	110.1	http://www.madimunsankhuwasabha.gov.np/
90	Makalu Rural Municipality	9	RURAL_MUNICIPALITY	519.45	http://www.makalumun.gov.np/
91	Silichong Rural Municipality	9	RURAL_MUNICIPALITY	293.26	http://www.silichongmun.gov.np/
92	Sabhapokhari Rural Municipality	9	RURAL_MUNICIPALITY	222.08	http://www.savapokharimun.gov.np/
93	Chichila Rural Municipality	9	RURAL_MUNICIPALITY	88.63	http://www.chichilamun.gov.np/
94	BhotKhola Rural Municipality	9	RURAL_MUNICIPALITY	639.01	http://www.bhotkholamun.gov.np/
95	Solu Dudhkunda Municipality	10	MUNICIPALITY	538.09	http://www.solududhkundamun.gov.np/
96	Mapya Dudhkoshi Rural Municipality	10	RURAL_MUNICIPALITY	167.67	http://www.dudhkoshimun.gov.np/
97	Necha Salyan Rural Municipality	10	RURAL_MUNICIPALITY	94.49	http://www.nechasalyanmun.gov.np/
98	Thulung Dudhkoshi Rural Municipality	10	RURAL_MUNICIPALITY	144.6	http://www.thulungdudhkoshimun.gov.np/
99	Maha Kulung Rural Municipality	10	RURAL_MUNICIPALITY	648.05	http://www.mahakulungmun.gov.np/
100	Sotang Rural Municipality	10	RURAL_MUNICIPALITY	103	http://www.sotangmun.gov.np/
101	Khumbu PasangLhamu Rural Municipality	10	RURAL_MUNICIPALITY	1539.11	http://www.khumbupasanglhamumun.gov.np/
102	Likhu Pike Rural Municipality	10	RURAL_MUNICIPALITY	124.38	http://www.likhupikemun.gov.np/
103	BarahaKshetra Municipality	11	MUNICIPALITY	222.09	http://www.barahamun.gov.np/
104	Inaruwa Municipality	11	MUNICIPALITY	77.92	http://www.inaruwamun.gov.np/
105	Duhabi Municipality	11	MUNICIPALITY	76.67	http://www.duhabimun.gov.np/
106	Ramdhuni Municipality	11	MUNICIPALITY	91.69	http://www.ramdhunimun.gov.np/
107	Itahari Sub-Metropolitan City	11	SUB_METROPOLITAN	93.78	http://www.itaharimun.gov.np/
108	Dharan Sub-Metropolitan City	11	SUB_METROPOLITAN	192.32	http://www.dharan.gov.np/
109	Koshi Rural Municipality	11	RURAL_MUNICIPALITY	75.98	http://www.koshimun.gov.np/
110	Harinagar Rural Municipality	11	RURAL_MUNICIPALITY	52.29	http://www.harinagaramun.gov.np/
111	Bhokraha Narsingh Rural Municipality	11	RURAL_MUNICIPALITY	63.37	http://www.bhokrahamun.gov.np/
112	Dewangunj Rural Municipality	11	RURAL_MUNICIPALITY	53.56	http://www.dewanganjmun.gov.np/
113	Gadhi Rural Municipality	11	RURAL_MUNICIPALITY	67.7	http://www.gadhimun.gov.np/
114	Barju Rural Municipality	11	RURAL_MUNICIPALITY	69.43	http://www.barjumun.gov.np/
115	Phungling Municipality	12	MUNICIPALITY	125.57	http://www.phunglingmun.gov.np/
116	Sirijangha Rural Municipality	12	RURAL_MUNICIPALITY	481.09	http://www.sirijanghamun.gov.np/
117	Aathrai Triveni Rural Municipality	12	RURAL_MUNICIPALITY	88.83	http://www.aathraitribenimun.gov.np/
118	Pathibhara Yangwarak Rural Municipality	12	RURAL_MUNICIPALITY	93.76	http://www.yangwarakmuntaplejung.gov.np/
119	Meringden Rural Municipality	12	RURAL_MUNICIPALITY	210.33	http://www.meringdenmun.gov.np/
120	Sidingwa Rural Municipality	12	RURAL_MUNICIPALITY	206	http://www.sidingbamun.gov.np/
121	Phaktanglung Rural Municipality	12	RURAL_MUNICIPALITY	1858.51	http://www.phaktanglungmun.gov.np/
122	Maiwa Khola Rural Municipality	12	RURAL_MUNICIPALITY	138	http://www.maiwakholamun.gov.np/
123	Mikwa Khola Rural Municipality	12	RURAL_MUNICIPALITY	442.96	http://www.mikwakholamun.gov.np/
124	Myanglung Municipality	13	MUNICIPALITY	100.21	http://www.myanglungmun.gov.np/
125	Laligurans Municipality	13	MUNICIPALITY	90.27	http://www.laliguransmun.gov.np/
126	Aathrai Rural Municipality	13	RURAL_MUNICIPALITY	167.07	http://www.aathraimun.gov.np/
127	Phedap Rural Municipality	13	RURAL_MUNICIPALITY	110.83	http://www.phedapmun.gov.np/
128	Chhathar Rural Municipality	13	RURAL_MUNICIPALITY	133.93	http://www.chhatharmun.gov.np/
129	Menchayayem Rural Municipality	13	RURAL_MUNICIPALITY	70.09	http://www.menchhayayemmun.gov.np/
130	Triyuga Municipality	14	MUNICIPALITY	547.43	http://www.triyugamun.gov.np/
131	Katari Municipality	14	MUNICIPALITY	424.89	http://www.katarimun.gov.np/
132	Chaudandigadhi Municipality	14	MUNICIPALITY	283.78	http://www.chaudandigadhimun.gov.np/
133	Belaka Municipality	14	MUNICIPALITY	344.73	http://www.belakamun.gov.np/
134	Udayapurgadhi Rural Municipality	14	RURAL_MUNICIPALITY	269.51	http://www.udayapurgadhimun.gov.np/
135	Rautamai Rural Municipality	14	RURAL_MUNICIPALITY	204.08	http://www.rautamaimun.gov.np/
136	Tapli Rural Municipality	14	RURAL_MUNICIPALITY	119.11	http://www.taplimun.gov.np/
137	Limchungbung Rural Municipality	14	RURAL_MUNICIPALITY	106.8	http://www.sunkoshimunudayapur.gov.np/
138	Birgunj Metropolitan City	15	METROPOLITAN	132.07	http://www.birgunjmun.gov.np/
139	Bahudarmai Municipality	15	MUNICIPALITY	31.55	http://www.bahudarmaimun.gov.np/
140	Parsagadhi Municipality	15	MUNICIPALITY	99.69	http://www.parsagadhimun.gov.np/
141	Pokhariya Municipality	15	MUNICIPALITY	32.47	http://www.pokhariyamun.gov.np/
142	Bindabasini Rural Municipality	15	RURAL_MUNICIPALITY	26.04	http://www.bindabasinimun.gov.np/
143	Dhobini Rural Municipality	15	RURAL_MUNICIPALITY	24.41	http://www.dhobinimun.gov.np/
144	Chhipaharmai Rural Municipality	15	RURAL_MUNICIPALITY	24.9	http://www.chhipaharmaimun.gov.np/
145	Jagarnathpur Rural Municipality	15	RURAL_MUNICIPALITY	45.29	http://www.jagarnathpurmun.gov.np/
146	Jirabhawani Rural Municipality	15	RURAL_MUNICIPALITY	55.39	http://www.jirabhawanimun.gov.np/
147	Kalikamai Rural Municipality	15	RURAL_MUNICIPALITY	24.33	http://www.kalikamaimun.gov.np/
148	Pakaha Mainpur Rural Municipality	15	RURAL_MUNICIPALITY	21.26	http://www.pakahamainpurmun.gov.np/
149	Paterwa Sugauli Rural Municipality	15	RURAL_MUNICIPALITY	64.29	http://www.paterwasugaulimun.gov.np/
150	Sakhuwa Prasauni Rural Municipality	15	RURAL_MUNICIPALITY	74.27	http://www.sakhuwaprasaunimun.gov.np/
151	Thori Rural Municipality	15	RURAL_MUNICIPALITY	128.67	http://www.thorimun.gov.np/
152	Kalaiya Sub-Metropolitan City	16	SUB_METROPOLITAN	108.94	http://www.kalaiyamun.gov.np/
153	Jitpur Simara Sub-Metropolitan City	16	SUB_METROPOLITAN	312.18	http://www.jeetpursimaramun.gov.np/
154	Kolhabi Municipality	16	MUNICIPALITY	157.4	http://www.kolhabimun.gov.np/
155	Nijgadh Municipality	16	MUNICIPALITY	289.43	http://www.nijgadhmun.gov.np/
156	Mahagadhimai Municipality	16	MUNICIPALITY	55.32	http://www.mahagadimaimun.gov.np/
157	Simaraungadh Municipality	16	MUNICIPALITY	42.65	http://www.simraungadhmun.gov.np/
158	Pacharauta Municipality	16	MUNICIPALITY	44.01	http://www.pachrautamun.gov.np/
159	Pheta Rural Municipality	16	RURAL_MUNICIPALITY	23.65	http://www.phetamun.gov.np/
160	Bishrampur Rural Municipality	16	RURAL_MUNICIPALITY	19.81	http://www.bishrampurmun.gov.np/
161	Prasauni Rural Municipality	16	RURAL_MUNICIPALITY	20.24	http://www.prasaunimun.gov.np/
162	Adarsh Kotwal Rural Municipality	16	RURAL_MUNICIPALITY	36.25	http://www.aadarshakotwalmun.gov.np/
163	Karaiyamai Rural Municipality	16	RURAL_MUNICIPALITY	47.69	http://www.karaiyamaimun.gov.np/
164	Devtal Rural Municipality	16	RURAL_MUNICIPALITY	23.31	http://www.devtalmun.gov.np/
165	Parwanipur Rural Municipality	16	RURAL_MUNICIPALITY	15.48	http://www.parwanipurmun.gov.np/
166	Baragadhi Rural Municipality	16	RURAL_MUNICIPALITY	39.29	http://www.baragadhimun.gov.np/
167	Suwarna Rural Municipality	16	RURAL_MUNICIPALITY	36.84	http://www.suwarnamun.gov.np/
168	Baudhimai Municipality	17	MUNICIPALITY	35.343	http://www.baudhimaimun.gov.np/
169	Brindaban Municipality	17	MUNICIPALITY	95.4	http://www.brindawanmun.gov.np/
170	Chandrapur Municipality	17	MUNICIPALITY	249.96	http://www.chandrapurmun.gov.np/
171	Dewahi Gonahi Municipality	17	MUNICIPALITY	33.99	http://www.dewahigonahimun.gov.np/
172	Gadhimai Municipality	17	MUNICIPALITY	49.44	http://www.gadhimaimun.gov.np/
173	Guruda Municipality	17	MUNICIPALITY	44.46	http://www.garudamun.gov.np/
174	Gaur Municipality	17	MUNICIPALITY	21.53	http://www.gaurmun.gov.np/
175	Gujara Municipality	17	MUNICIPALITY	150.33	http://www.gujaramun.gov.np/
176	Ishanath Municipality	17	MUNICIPALITY	35.17	http://www.ishnathmun.gov.np/
177	Katahariya Municipality	17	MUNICIPALITY	40.69	http://www.katahariyamun.gov.np/
178	Madhav Narayan Municipality	17	MUNICIPALITY	48.53	http://www.madhavnarayanmun.gov.np/
179	Maulapur Municipality	17	MUNICIPALITY	34.75	http://www.maulapurmun.gov.np/
180	Paroha Municipality	17	MUNICIPALITY	37.45	http://www.parohamun.gov.np/
181	Phatuwa Bijayapur Municipality	17	MUNICIPALITY	65.24	http://www.phatuwabijaypurmun.gov.np/
182	Rajdevi Municipality	17	MUNICIPALITY	28.21	http://www.rajdevimun.gov.np/
183	Rajpur Municipality	17	MUNICIPALITY	31.41	https://rajpurmunrautahat.gov.np/
184	Durga Bhagwati Rural Municipality	17	RURAL_MUNICIPALITY	19.8	http://www.durgabhagawatimun.gov.np/
185	Yamunamai Rural Municipality	17	RURAL_MUNICIPALITY	16.7	http://www.yamunamaimun.gov.np/
186	Bagmati Municipality	18	MUNICIPALITY	101.18	http://www.bagmatimunsarlahi.gov.np/
187	Balara Municipality	18	MUNICIPALITY	48.55	http://www.balramun.gov.np/
188	Barahathwa Municipality	18	MUNICIPALITY	107.05	http://www.barhathwamun.gov.np/
189	Godaita Municipality	18	MUNICIPALITY	48.62	http://www.godaitamun.gov.np/
190	Hariwan Municipality	18	MUNICIPALITY	86.12	http://www.harionmun.gov.np/
191	Haripur Municipality	18	MUNICIPALITY	66.86	http://www.haripurmun.gov.np/
192	Haripurwa Municipality	18	MUNICIPALITY	30.5	http://www.haripurwamun.gov.np/
193	Ishowrpur Municipality	18	MUNICIPALITY	163.83	http://www.ishworpurmun.gov.np/
194	Kabilasi Municipality	18	MUNICIPALITY	48.11	http://www.kawilasimun.gov.np/
195	Lalbandi Municipality	18	MUNICIPALITY	238.5	http://www.lalbandimun.gov.np/
196	Malangawa Municipality	18	MUNICIPALITY	30.44	http://www.malangwamun.gov.np/
197	Basbariya Rural Municipality	18	RURAL_MUNICIPALITY	29.42	http://www.basbariyamun.gov.np/
198	Bisnu Rural Municipality	18	RURAL_MUNICIPALITY	28.09	http://www.bishnumun.gov.np/
199	Brahampuri Rural Municipality	18	RURAL_MUNICIPALITY	33.89	http://www.brahmapurimun.gov.np/
200	Chakraghatta Rural Municipality	18	RURAL_MUNICIPALITY	25.14	http://www.chakraghattamun.gov.np/
201	Chandranagar Rural Municipality	18	RURAL_MUNICIPALITY	47.5	http://www.chandranagarmun.gov.np/
202	Dhankaul Rural Municipality	18	RURAL_MUNICIPALITY	45.94	http://www.dhankaulmun.gov.np/
203	Kaudena Rural Municipality	18	RURAL_MUNICIPALITY	25.33	http://www.kaudenamun.gov.np/
204	Parsa Rural Municipality	18	RURAL_MUNICIPALITY	23.12	http://www.parsamun.gov.np/
205	Ramnagar Rural Municipality	18	RURAL_MUNICIPALITY	26.44	http://www.ramnagarmun.gov.np/
206	Lahan Municipality	19	MUNICIPALITY	167.17	http://www.lahanmun.gov.np/
207	Dhangadhimai Municipality	19	MUNICIPALITY	159.51	http://www.dhangadhimaimun.gov.np/
208	Siraha Municipality	19	MUNICIPALITY	94.2	http://www.sirahamun.gov.np/
209	Golbazar Municipality	19	MUNICIPALITY	111.94	http://www.golbazarmun.gov.np/
210	Mirchaiya Municipality	19	MUNICIPALITY	91.97	http://www.mirchaiyamun.gov.np/
211	Kalyanpur Municipality	19	MUNICIPALITY	76.81	http://www.kalyanpurmun.gov.np/
212	Karjanha Municipality	19	MUNICIPALITY	76.84	http://www.karjanhamun.gov.np/
213	Sukhipur Municipality	19	MUNICIPALITY	54.78	http://www.sukhipurmun.gov.np/
214	Bhagwanpur Rural Municipality	19	RURAL_MUNICIPALITY	33.03	http://www.bhagwanpurmun.gov.np/
215	Aurahi Rural Municipality	19	RURAL_MUNICIPALITY	35.87	http://www.aurahimunsiraha.gov.np/
216	Bishnupur Rural Municipality	19	RURAL_MUNICIPALITY	26.34	http://www.bishnupurmunsiraha.gov.np/
217	Bariyarpatti Rural Municipality	19	RURAL_MUNICIPALITY	37.72	http://www.bariyapattimun.gov.np/
218	Lakshmipur Patari Rural Municipality	19	RURAL_MUNICIPALITY	42.33	http://www.laxmipurpatarimun.gov.np/
219	Naraha Rural Municipality	19	RURAL_MUNICIPALITY	29.28	http://www.narahamun.gov.np/
220	SakhuwanankarKatti Rural Municipality	19	RURAL_MUNICIPALITY	32.84	http://www.sakhuwanankarkattimun.gov.np/
221	Arnama Rural Municipality	19	RURAL_MUNICIPALITY	37.76	http://www.anarmamun.gov.np/
222	Navarajpur Rural Municipality	19	RURAL_MUNICIPALITY	32.18	http://www.nawarajpurmun.gov.np/
223	Janakpurdham Sub-Metropolitan City	20	SUB_METROPOLITAN	91.97	http://www.janakpurmun.gov.np/
224	Chhireshwarnath Municipality	20	MUNICIPALITY	50.85	http://www.kshireshwornathmun.gov.np/
225	Ganeshman Charnath Municipality	20	MUNICIPALITY	244.31	http://www.ganeshmancharnathmun.gov.np/
226	Dhanushadham Municipality	20	MUNICIPALITY	91.64	http://www.dhanushadhammun.gov.np/
227	Nagarain Municipality	20	MUNICIPALITY	39	http://www.nagrainmun.gov.np/
228	Bideha Municipality	20	MUNICIPALITY	45.51	http://www.bidehamun.gov.np/
229	Mithila Municipality	20	MUNICIPALITY	187.93	http://www.mithilamun.gov.np/
230	Sahidnagar Municipality	20	MUNICIPALITY	57.37	http://www.shahidnagarmun.gov.np/
231	Sabaila Municipality	20	MUNICIPALITY	64.47	http://www.sabailamun.gov.np/
232	Kamala Municipality	20	MUNICIPALITY	65.85	http://www.kamalamun.gov.np/
233	MithilaBihari Municipality	20	MUNICIPALITY	37.6	http://www.mithilabiharimun.gov.np/
234	Hansapur Municipality	20	MUNICIPALITY	48.71	http://www.hansapurmun.gov.np/
235	Janaknandani Rural Municipality	20	RURAL_MUNICIPALITY	27.62	http://www.janaknandinimun.gov.np/
236	Bateshwar Rural Municipality	20	RURAL_MUNICIPALITY	31.66	http://www.bateshwormun.gov.np/
237	Mukhiyapatti Musharniya Rural Municipality	20	RURAL_MUNICIPALITY	26.84	http://www.mukhiyapattimusaharmiyamun.gov.np/
238	Lakshminya Rural Municipality	20	RURAL_MUNICIPALITY	30.66	http://www.laxminiyamun.gov.np/
239	Aaurahi Rural Municipality	20	RURAL_MUNICIPALITY	25.56	http://www.aurahimundhanusha.gov.np/
240	Dhanauji Rural Municipality	20	RURAL_MUNICIPALITY	22	http://www.dhanaujimun.gov.np/
241	Bodebarsain Municipality	21	MUNICIPALITY	58.93	http://www.bodebarsainmun.gov.np/
242	Dakneshwori Municipality	21	MUNICIPALITY	69.11	http://www.dakneshworimun.gov.np/
243	Hanumannagar Kankalini Municipality	21	MUNICIPALITY	118.19	http://www.hanumannagarkankalinimun.gov.np/
244	Kanchanrup Municipality	21	MUNICIPALITY	117.34	http://www.kanchanrupmun.gov.np/
245	Khadak Municipality	21	MUNICIPALITY	96.77	http://www.khadakmun.gov.np/
246	Shambhunath Municipality	21	MUNICIPALITY	108.71	http://www.shambhunathmun.gov.np/
247	Saptakoshi Municipality	21	MUNICIPALITY	60.25	http://www.saptakoshimun.gov.np/
248	Surunga Municipality	21	MUNICIPALITY	107.04	http://www.surungamun.gov.np/
249	Rajbiraj Municipality	21	MUNICIPALITY	55	http://www.rajbirajmun.gov.np/
250	Agnisaira Krishnasavaran Rural Municipality	21	RURAL_MUNICIPALITY	103.08	http://www.agnisairkrishnasawaranmun.gov.np/
251	Balan-Bihul Rural Municipality	21	RURAL_MUNICIPALITY	33.04	http://www.balanbihulmun.gov.np/
252	Rajgadh Rural Municipality	21	RURAL_MUNICIPALITY	47.9	http://www.rajgadhmun.gov.np/
253	Bishnupur Rural Municipality	21	RURAL_MUNICIPALITY	37	http://www.bishnupurmunsaptari.gov.np/
254	Chhinnamasta Rural Municipality	21	RURAL_MUNICIPALITY	38.71	http://www.chhinnamastamun.gov.np/
255	Mahadeva Rural Municipality	21	RURAL_MUNICIPALITY	34.97	http://www.mahadevamun.gov.np/
256	Rupani Rural Municipality	21	RURAL_MUNICIPALITY	56.08	http://www.rupanimun.gov.np/
257	Tilathi Koiladi Rural Municipality	21	RURAL_MUNICIPALITY	32.91	http://www.tilathikoiladimun.gov.np/
258	Tirhut Rural Municipality	21	RURAL_MUNICIPALITY	37.81	http://www.tirahutmun.gov.np/
259	Aaurahi Municipality	22	MUNICIPALITY	35.76	http://www.aurahimunmahottari.gov.np/
260	Balawa Municipality	22	MUNICIPALITY	44.07	http://www.balwamun.gov.np/
261	Bardibas Municipality	22	MUNICIPALITY	315.57	http://www.bardibasmun.gov.np/
262	Bhangaha Municipality	22	MUNICIPALITY	77.21	http://www.bhagahamun.gov.np/
263	Gaushala Municipality	22	MUNICIPALITY	144.73	http://www.gaushalamun.gov.np/
264	Jaleshor Municipality	22	MUNICIPALITY	44.26	http://www.jaleshwormun.gov.np/
265	Loharpatti Municipality	22	MUNICIPALITY	50.06	http://www.loharpattimun.gov.np/
266	Manara Shiswa Municipality	22	MUNICIPALITY	49.73	http://www.manrashiswamun.gov.np/
267	Matihani Municipality	22	MUNICIPALITY	29.02	http://www.matihanimun.gov.np/
268	Ramgopalpur Municipality	22	MUNICIPALITY	39.54	http://www.ramgopalpurmun.gov.np/
269	Ekdara Rural Municipality	22	RURAL_MUNICIPALITY	24	http://www.ekdaramun.gov.np/
270	Mahottari Rural Municipality	22	RURAL_MUNICIPALITY	28.08	http://www.mahottarimun.gov.np/
271	Pipara Rural Municipality	22	RURAL_MUNICIPALITY	39.98	http://www.pipramun.gov.np/
272	Samsi Rural Municipality	22	RURAL_MUNICIPALITY	21.57	http://www.samsimun.gov.np/
273	Sonama Rural Municipality	22	RURAL_MUNICIPALITY	57.77	http://www.sonmamun.gov.np/
274	Bhaktapur Municipality	23	MUNICIPALITY	6.89	http://www.bhaktapurmun.gov.np/
275	Changunarayan Municipality	23	MUNICIPALITY	62.98	http://www.changunarayanmun.gov.np/
276	Suryabinayak Municipality	23	MUNICIPALITY	42.45	http://www.suryabinayakmun.gov.np/
277	Madhyapur Thimi Municipality	23	MUNICIPALITY	11.47	http://www.madhyapurthimimun.gov.np/
278	Bharatpur Metropolitan City	24	METROPOLITAN	432.95	http://www.bharatpurmun.gov.np/
279	Kalika Municipality	24	MUNICIPALITY	149.08	http://www.kalikamunchitwan.gov.np/
280	Khairhani Municipality	24	MUNICIPALITY	85.55	http://www.khairhanimun.gov.np/
281	Madi Municipality	24	MUNICIPALITY	218.24	http://www.madimunchitwan.gov.np/
282	Ratnagar Municipality	24	MUNICIPALITY	68.68	http://www.ratnanagarmun.gov.np/
283	Rapti Municipality	24	MUNICIPALITY	212.31	http://www.raptimunchitwan.gov.np/
284	Ichchhakamana Rural Municipality	24	RURAL_MUNICIPALITY	166.73	http://www.ichchhakamanamun.gov.np/
285	Dhunibeshi Municipality	25	MUNICIPALITY	96.3	http://www.dhunibeshimun.gov.np/
286	Nilkantha Municipality	25	MUNICIPALITY	197.7	http://www.neelakanthamun.gov.np/
287	Khaniyabas Rural Municipality	25	RURAL_MUNICIPALITY	120.8	http://www.khaniyabasmun.gov.np/
288	Gajuri Rural Municipality	25	RURAL_MUNICIPALITY	138.66	http://www.gajurimun.gov.np/
289	Galchhi Rural Municipality	25	RURAL_MUNICIPALITY	129.08	http://www.galchhimun.gov.np/
290	Gangajamuna Rural Municipality	25	RURAL_MUNICIPALITY	152.72	http://www.gangajamunamun.gov.np/
291	Jwalamukhi Rural Municipality	25	RURAL_MUNICIPALITY	114.04	http://www.jwalamukhimun.gov.np/
292	Thakre Rural Municipality	25	RURAL_MUNICIPALITY	96.41	http://www.thakremun.gov.np/
293	Netrawati Dabjong Rural Municipality	25	RURAL_MUNICIPALITY	181.78	http://www.netrawatimun.gov.np/
294	Benighat Rorang Rural Municipality	25	RURAL_MUNICIPALITY	206.52	http://www.benighatrorangmun.gov.np/
295	Rubi Valley Rural Municipality	25	RURAL_MUNICIPALITY	401.85	http://www.rubivalleymun.gov.np/
296	Siddhalek Rural Municipality	25	RURAL_MUNICIPALITY	106.09	http://www.siddhalekmun.gov.np/
297	Tripurasundari Rural Municipality	25	RURAL_MUNICIPALITY	271.23	http://www.tripurasundarimundhading.gov.np/
298	Bhimeswor Municipality	26	MUNICIPALITY	132.5	http://www.bhimeshwormun.gov.np/
299	Jiri Municipality	26	MUNICIPALITY	211.27	http://www.jirimun.gov.np/
300	Kalinchok Rural Municipality	26	RURAL_MUNICIPALITY	132.49	http://www.kalinchowkmun.gov.np/
301	Melung Rural Municipality	26	RURAL_MUNICIPALITY	86.54	http://www.melungmun.gov.np/
302	Bigu Rural Municipality	26	RURAL_MUNICIPALITY	663.2	http://www.bigumun.gov.np/
303	Gaurishankar Rural Municipality	26	RURAL_MUNICIPALITY	681.39	http://www.gaurishankarmun.gov.np/
304	Baiteshowr Rural Municipality	26	RURAL_MUNICIPALITY	80.41	http://www.baiteshwormun.gov.np/
305	Sailung Rural Municipality	26	RURAL_MUNICIPALITY	128.67	http://www.shailungmun.gov.np/
306	Tamakoshi Rural Municipality	26	RURAL_MUNICIPALITY	153.06	http://www.tamakoshimun.gov.np/
307	Kathmandu Metropolitan City	27	METROPOLITAN	49.45	http://www.kathmandu.gov.np/
308	Gokarneshwar Municipality	27	MUNICIPALITY	58.5	http://www.gokarneshwormun.gov.np/
309	Kirtipur Municipality	27	MUNICIPALITY	14.76	http://www.kirtipurmun.gov.np/
310	Kageshwari-Manohara Municipality	27	MUNICIPALITY	27.38	http://www.kageshworimanoharamun.gov.np/
311	Chandragiri Municipality	27	MUNICIPALITY	43.92	http://www.chandragirimun.gov.np/
312	Tokha Municipality	27	MUNICIPALITY	17.11	http://www.tokhamun.gov.np/
313	Tarakeshwar Municipality	27	MUNICIPALITY	54.95	http://www.tarakeshwormunkathmandu.gov.np/
314	Dakshinkali Municipality	27	MUNICIPALITY	42.68	http://www.dakshinkalimun.gov.np/
315	Nagarjun Municipality	27	MUNICIPALITY	29.85	http://www.nagarjunmun.gov.np/
316	Budhalikantha Municipality	27	MUNICIPALITY	34.8	http://www.budhanilkanthamun.gov.np/
317	Shankharapur Municipality	27	MUNICIPALITY	60.21	http://www.shankharapurmun.gov.np/
318	Dhulikhel Municipality	28	MUNICIPALITY	55	http://www.dhulikhelmun.gov.np/
319	Namobuddha Municipality	28	MUNICIPALITY	102	http://www.namobuddhamun.gov.np/
320	Panauti Municipality	28	MUNICIPALITY	118	http://www.panautimun.gov.np/
321	Panchkhal Municipality	28	MUNICIPALITY	103	http://www.panchkhalmun.gov.np/
322	Banepa Municipality	28	MUNICIPALITY	55	http://www.banepamun.gov.np/
323	Mandandeupur Municipality	28	MUNICIPALITY	89	http://www.mandandeupurmun.gov.np/
324	Khani Khola Rural Municipality	28	RURAL_MUNICIPALITY	132	http://www.khanikholamun.gov.np/
325	Chauri Deurali Rural Municipality	28	RURAL_MUNICIPALITY	98	http://www.chaurideuralimun.gov.np/
326	Temal Rural Municipality	28	RURAL_MUNICIPALITY	89	http://www.temalmun.gov.np/
327	Bethanchok Rural Municipality	28	RURAL_MUNICIPALITY	101	http://www.bethanchowkmun.gov.np/
328	Bhumlu Rural Municipality	28	RURAL_MUNICIPALITY	91	http://www.bhumlumun.gov.np/
329	Mahabharat Rural Municipality	28	RURAL_MUNICIPALITY	186	http://www.mahabharatmun.gov.np/
330	Roshi Rural Municipality	28	RURAL_MUNICIPALITY	176	http://www.roshimun.gov.np/
331	Lalitpur Metropolitan City	29	METROPOLITAN	36.12	http://www.lalitpurmun.gov.np/
332	Mahalaxmi Municipality	29	MUNICIPALITY	26.51	http://www.mahalaxmimunlalitpur.gov.np/
333	Godawari Municipality	29	MUNICIPALITY	96.11	http://www.godawarimunlalitpur.gov.np/
334	Konjyosom Rural Municipality	29	RURAL_MUNICIPALITY	44.16	http://www.konjyosommun.gov.np/
335	Bagmati Rural Municipality	29	RURAL_MUNICIPALITY	111.49	http://www.bagmatimunlalitpur.gov.np/
336	Mahankal Rural Municipality	29	RURAL_MUNICIPALITY	82.44	http://www.mahankalmun.gov.np/
337	Hetauda Sub-Metropolitan City	30	SUB_METROPOLITAN	261.59	http://www.hetaudamun.gov.np/
338	Thaha Municipality	30	MUNICIPALITY	191.12	http://www.thahamun.gov.np/
339	Bhimphedi Rural Municipality	30	RURAL_MUNICIPALITY	245.27	http://www.bhimphedimun.gov.np/
340	Makawanpurgadhi Rural Municipality	30	RURAL_MUNICIPALITY	148.72	http://www.makawanpurgadhimun.gov.np/
341	Manahari Rural Municipality	30	RURAL_MUNICIPALITY	199.52	http://www.manaharimun.gov.np/
342	Raksirang Rural Municipality	30	RURAL_MUNICIPALITY	226.7	http://www.raksirangmun.gov.np/
343	Bakaiya Rural Municipality	30	RURAL_MUNICIPALITY	393.75	http://www.bakaiyamun.gov.np/
344	Bagmati Rural Municipality	30	RURAL_MUNICIPALITY	311.79	http://www.bagmatimunmakawanpur.gov.np/
345	Kailash Rural Municipality	30	RURAL_MUNICIPALITY	204.48	http://www.kailashmun.gov.np/
346	Indrasarowar Rural Municipality	30	RURAL_MUNICIPALITY	97.34	http://www.indrasarowarmun.gov.np/
347	Bidur Municipality	31	MUNICIPALITY	130.01	http://www.bidurmun.gov.np/
348	Belkotgadhi Municipality	31	MUNICIPALITY	155.6	http://www.belkotgadhimun.gov.np/
349	Kakani Rural Municipality	31	RURAL_MUNICIPALITY	87.97	http://www.kakanimun.gov.np/
350	Panchakanya Rural Municipality	31	RURAL_MUNICIPALITY	53.47	http://www.panchakanyamun.gov.np/
351	Likhu Rural Municipality	31	RURAL_MUNICIPALITY	47.88	http://www.likhumunnuwakot.gov.np/
352	Dupcheshwar Rural Municipality	31	RURAL_MUNICIPALITY	131.62	http://www.dupcheshwormun.gov.np/
353	Shivapuri Rural Municipality	31	RURAL_MUNICIPALITY	101.5	http://www.shivapurimun.gov.np/
354	Tadi Rural Municipality	31	RURAL_MUNICIPALITY	69.8	http://www.tadimun.gov.np/
355	Suryagadhi Rural Municipality	31	RURAL_MUNICIPALITY	49.09	http://www.suryagadhimun.gov.np/
356	Tarkeshwar Rural Municipality	31	RURAL_MUNICIPALITY	72.62	http://www.tarakeshwormunnuwakot.gov.np/
357	Kispang Rural Municipality	31	RURAL_MUNICIPALITY	82.57	http://www.kispangmun.gov.np/
358	Myagang Rural Municipality	31	RURAL_MUNICIPALITY	97.83	http://www.meghangmun.gov.np/
359	Manthali Municipality	32	MUNICIPALITY	211.78	http://www.manthalimun.gov.np/
360	Ramechhap Municipality	32	MUNICIPALITY	202.45	http://www.ramechhapmun.gov.np/
361	Umakunda Rural Municipality	32	RURAL_MUNICIPALITY	451.99	http://www.umakundamun.gov.np/
362	Khandadevi Rural Municipality	32	RURAL_MUNICIPALITY	150.7	http://www.khandadevimun.gov.np/
363	Doramba Rural Municipality	32	RURAL_MUNICIPALITY	140.88	http://www.dorambamun.gov.np/
364	Gokulganga Rural Municipality	32	RURAL_MUNICIPALITY	198.4	http://www.gokulgangamun.gov.np/
365	LikhuTamakoshi Rural Municipality	32	RURAL_MUNICIPALITY	124.51	http://www.likhumunramechhap.gov.np/
366	Sunapati Rural Municipality	32	RURAL_MUNICIPALITY	86.98	http://www.sunapatimun.gov.np/
367	Kalika Rural Municipality	33	RURAL_MUNICIPALITY	192.54	http://www.kalikamunrasuwa.gov.np/
368	Gosaikunda Rural Municipality	33	RURAL_MUNICIPALITY	978.77	http://www.gosaikundamun.gov.np/
369	Naukunda Rural Municipality	33	RURAL_MUNICIPALITY	126.99	http://www.naukundamun.gov.np/
370	Parbatikunda Rural Municipality	33	RURAL_MUNICIPALITY	682.23	http://www.parbatikundamun.gov.np/
371	Uttargaya Rural Municipality	33	RURAL_MUNICIPALITY	104.51	http://www.uttargayamun.gov.np/
372	Kamalamai Municipality	34	MUNICIPALITY	428.57	http://www.kamalamaimun.gov.np/
373	Dudhauli Municipality	34	MUNICIPALITY	390.39	http://www.dudhaulimun.gov.np/
374	Sunkoshi Rural Municipality	34	RURAL_MUNICIPALITY	154.68	http://www.sunkoshimunsindhuli.gov.np/
375	Hariharpurgadhi Rural Municipality	34	RURAL_MUNICIPALITY	343.9	http://www.hariharpurgadhimun.gov.np/
376	Tinpatan Rural Municipality	34	RURAL_MUNICIPALITY	280.26	http://www.tinpatanmun.gov.np/
377	Marin Rural Municipality	34	RURAL_MUNICIPALITY	324.55	http://www.marinmun.gov.np/
378	Golanjor Rural Municipality	34	RURAL_MUNICIPALITY	184.13	http://www.golanjormun.gov.np/
379	Phikkal Rural Municipality	34	RURAL_MUNICIPALITY	186.06	http://www.phikkalmun.gov.np/
380	Ghyanglekh Rural Municipality	34	RURAL_MUNICIPALITY	166.77	http://www.ghyanglekhmun.gov.np/
381	Chautara Sangachowkgadi Municipality	35	MUNICIPALITY	165.25	http://www.chautarasangachowkgadhimun.gov.np/
382	Bahrabise Municipality	35	MUNICIPALITY	96.73	http://www.bahrabisemun.gov.np/
383	Melamchi Municipality	35	MUNICIPALITY	158.17	http://www.melamchimun.gov.np/
384	Balephi Rural Municipality	35	RURAL_MUNICIPALITY	61.6	http://www.balephimun.gov.np/
385	Sunkoshi Rural Municipality	35	RURAL_MUNICIPALITY	71.84	http://www.sunkoshimunsindhupalchowk.gov.np/
386	Indrawati Rural Municipality	35	RURAL_MUNICIPALITY	105.09	http://www.indrawatimun.gov.np/
387	Jugal Rural Municipality	35	RURAL_MUNICIPALITY	273.62	http://www.jugalmun.gov.np/
388	Panchpokhari Rural Municipality	35	RURAL_MUNICIPALITY	187.29	http://www.panchpokharithangpalmun.gov.np/
389	Bhotekoshi Rural Municipality	35	RURAL_MUNICIPALITY	278.31	http://www.bhotekoshimun.gov.np/
390	Lisankhu Rural Municipality	35	RURAL_MUNICIPALITY	98.61	http://www.lisankhupakharmun.gov.np/
391	Helambu Rural Municipality	35	RURAL_MUNICIPALITY	287.26	http://www.helambumun.gov.np/
392	Tripurasundari Rural Municipality	35	RURAL_MUNICIPALITY	94.28	http://www.tripurasundarimunsindhupalchowk.gov.np/
393	Baglung Municipality	36	MUNICIPALITY	98.01	http://www.baglungmun.gov.np/
394	Dhorpatan Municipality	36	MUNICIPALITY	222.85	http://www.dhorpatanmun.gov.np/
395	Galkot Municipality	36	MUNICIPALITY	194.39	http://www.galkotmun.gov.np/
396	Jaimuni Municipality	36	MUNICIPALITY	118.71	http://www.jaiminimun.gov.np/
397	Bareng Rural Municipality	36	RURAL_MUNICIPALITY	75.28	http://www.barengmun.gov.np/
398	Khathekhola Rural Municipality	36	RURAL_MUNICIPALITY	82.88	http://www.kathekholamun.gov.np/
399	Taman Khola Rural Municipality	36	RURAL_MUNICIPALITY	178.02	http://www.tamankholamun.gov.np/
400	Tara Khola Rural Municipality	36	RURAL_MUNICIPALITY	129.53	http://www.tarakholamun.gov.np/
401	Nishi Khola Rural Municipality	36	RURAL_MUNICIPALITY	244.37	http://www.nisikholamun.gov.np/
402	Badigad Rural Municipality	36	RURAL_MUNICIPALITY	178.68	http://www.badigadmun.gov.np/
403	Gorkha Municipality	37	MUNICIPALITY	131.86	http://www.gorkhamun.gov.np/
404	Palungtar Municipality	37	MUNICIPALITY	158.62	http://www.palungtarmun.gov.np/
405	Sulikot Rural Municipality	37	RURAL_MUNICIPALITY	200.63	http://www.sulikotmun.gov.np/
406	Siranchowk Rural Municipality	37	RURAL_MUNICIPALITY	121.66	http://www.siranchowkmun.gov.np/
407	Ajirkot Rural Municipality	37	RURAL_MUNICIPALITY	198.05	http://www.ajirkotmun.gov.np/
408	Chumnubri Rural Municipality	37	RURAL_MUNICIPALITY	1648.65	http://www.chumanuwrimun.gov.np/
409	Dharche Rural Municipality	37	RURAL_MUNICIPALITY	651.52	http://www.dharchemun.gov.np/
410	Bhimsen Thapa Rural Municipality	37	RURAL_MUNICIPALITY	101.25	http://www.bhimsenmun.gov.np/
411	Sahid Lakhan Rural Municipality	37	RURAL_MUNICIPALITY	147.97	http://www.shahidlakhanmun.gov.np/
412	Aarughat Rural Municipality	37	RURAL_MUNICIPALITY	160.79	http://www.aarughatmun.gov.np/
413	Gandaki Rural Municipality	37	RURAL_MUNICIPALITY	123.86	http://www.gandakimun.gov.np/
414	Pokhara Metropolitan City	38	METROPOLITAN	464.24	http://www.pokharamun.gov.np/
415	Annapurna Rural Municipality	38	RURAL_MUNICIPALITY	417.73	http://www.annapurnamunkaski.gov.np/
416	Machhapuchchhre Rural Municipality	38	RURAL_MUNICIPALITY	544.58	http://www.machhapuchhremun.gov.np/
417	Madi Rural Municipality	38	RURAL_MUNICIPALITY	563	http://www.madimunkaski.gov.np/
418	Rupa Rural Municipality	38	RURAL_MUNICIPALITY	94.81	http://www.rupamun.gov.np/
419	Besisahar Municipality	39	MUNICIPALITY	127.64	http://www.besishaharmun.gov.np/
420	Madhya Nepal Municipality	39	MUNICIPALITY	113.86	http://www.madhyanepalmun.gov.np/
421	Rainas Municipality	39	MUNICIPALITY	71.97	http://www.rainasmun.gov.np/
422	Sundarbazar Municipality	39	MUNICIPALITY	72.05	http://www.sundarbazarmun.gov.np/
423	Dordi Rural Municipality	39	RURAL_MUNICIPALITY	350.93	http://www.dordimun.gov.np/
424	Dudhpokhari Rural Municipality	39	RURAL_MUNICIPALITY	155.33	http://www.dudhpokharimun.gov.np/
425	Kwhlosothar Rural Municipality	39	RURAL_MUNICIPALITY	175.37	http://www.kwholasotharmun.gov.np/
426	Marsyangdi Rural Municipality	39	RURAL_MUNICIPALITY	597.25	http://www.marsyangdimun.gov.np/
427	Chame Rural Municipality	40	RURAL_MUNICIPALITY	78.86	http://www.chamemun.gov.np/
428	Nason Rural Municipality	40	RURAL_MUNICIPALITY	709.58	http://www.nasonmun.gov.np/
429	NarpaBhumi Rural Municipality	40	RURAL_MUNICIPALITY	837.54	http://www.narpabhumimun.gov.np/
430	Manang Ngisyang Rural Municipality	40	RURAL_MUNICIPALITY	694.63	http://www.manangngisyangmun.gov.np/
431	Gharpajhong Rural Municipality	41	RURAL_MUNICIPALITY	316	http://www.gharapjhongmun.gov.np/
432	Thasang Rural Municipality	41	RURAL_MUNICIPALITY	289	http://www.thasangmun.gov.np/
433	Barhagaun Muktichhetra Rural Municipality	41	RURAL_MUNICIPALITY	886	http://www.bahragaumuktichhetramun.gov.np/
434	Lomanthang Rural Municipality	41	RURAL_MUNICIPALITY	727	http://www.lomanthangmun.gov.np/
435	Lo-Ghekar Damodarkunda Rural Municipality	41	RURAL_MUNICIPALITY	1344	http://www.dalomemun.gov.np/
436	Beni Municipality	42	MUNICIPALITY	76.57	http://www.benimun.gov.np/
437	Annapurna Rural Municipality	42	RURAL_MUNICIPALITY	556.41	http://www.annapurnamunmyagdi.gov.np/
438	Dhaulagiri Rural Municipality	42	RURAL_MUNICIPALITY	1037	http://www.dhawalagirimun.gov.np/
439	Mangala Rural Municipality	42	RURAL_MUNICIPALITY	89	http://www.mangalamun.gov.np/
440	Malika Rural Municipality	42	RURAL_MUNICIPALITY	147	http://www.malikamunmyagdi.gov.np/
441	Raghuganga Rural Municipality	42	RURAL_MUNICIPALITY	379	http://www.raghugangamun.gov.np/
442	Kawasoti Municipality	43	MUNICIPALITY	108.34	http://www.kawasotimun.gov.np/
443	Gaindakot Municipality	43	MUNICIPALITY	159.93	http://www.gaindakotmun.gov.np/
444	Devachuli Municipality	43	MUNICIPALITY	112.72	http://www.devchulimun.gov.np/
445	Madhya Bindu Municipality	43	MUNICIPALITY	233.35	http://www.madhyabindumun.gov.np/
446	Baudikali Rural Municipality	43	RURAL_MUNICIPALITY	91.87	http://www.bungdikalimun.gov.np/
447	Bulingtar Rural Municipality	43	RURAL_MUNICIPALITY	147.68	http://www.bulingtarmun.gov.np/
448	Binayi Tribeni Rural Municipality	43	RURAL_MUNICIPALITY	288.06	http://www.binayitribenimun.gov.np/
449	Hupsekot Rural Municipality	43	RURAL_MUNICIPALITY	189.21	http://www.hupsekotmun.gov.np/
450	Kushma Municipality	44	MUNICIPALITY	93.18	http://www.kushmamun.gov.np/
451	Phalewas Municipality	44	MUNICIPALITY	85.7	http://www.phalewasmun.gov.np/
452	Jaljala Rural Municipality	44	RURAL_MUNICIPALITY	82.26	http://www.jaljalamun.gov.np/
453	Paiyun Rural Municipality	44	RURAL_MUNICIPALITY	42.65	http://www.paiyunmun.gov.np/
454	Mahashila Rural Municipality	44	RURAL_MUNICIPALITY	49.38	http://www.mahashilamun.gov.np/
455	Modi Rural Municipality	44	RURAL_MUNICIPALITY	143.6	http://www.modimun.gov.np/
456	Bihadi Rural Municipality	44	RURAL_MUNICIPALITY	44.8	http://www.bihadimun.gov.np/
457	Galyang Municipality	45	MUNICIPALITY	122.71	http://www.galyangmun.gov.np/
458	Chapakot Municipality	45	MUNICIPALITY	120.59	http://www.chapakotmun.gov.np/
459	Putalibazar Municipality	45	MUNICIPALITY	147.21	http://www.putalibazarmun.gov.np/
460	Bheerkot Municipality	45	MUNICIPALITY	78.23	http://www.bheerkotmun.gov.np/
461	Waling Municipality	45	MUNICIPALITY	128.4	http://www.walingmun.gov.np/
462	Arjun Chaupari Rural Municipality	45	RURAL_MUNICIPALITY	57.22	http://www.arjunchauparimun.gov.np/
463	Aandhikhola Rural Municipality	45	RURAL_MUNICIPALITY	69.61	http://www.aandhikholamun.gov.np/
464	Kaligandaki Rural Municipality	45	RURAL_MUNICIPALITY	73.51	http://www.kaligandakimunsyangja.gov.np/
465	Phedikhola Rural Municipality	45	RURAL_MUNICIPALITY	56.73	http://www.phedikholamun.gov.np/
466	Harinas Rural Municipality	45	RURAL_MUNICIPALITY	87.48	http://www.harinasmun.gov.np/
467	Biruwa Rural Municipality	45	RURAL_MUNICIPALITY	95.79	http://www.biruwamun.gov.np/
468	Bhanu Municipality	46	MUNICIPALITY	184	http://www.bhanumun.gov.np/
469	Bhimad Municipality	46	MUNICIPALITY	129	http://www.bhimadmun.gov.np/
470	Byas Municipality	46	MUNICIPALITY	248	http://www.vyasmun.gov.np/
471	Suklagandaki Municipality	46	MUNICIPALITY	165	http://www.shuklagandakimun.gov.np/
472	AnbuKhaireni Rural Municipality	46	RURAL_MUNICIPALITY	128	http://www.aanbookhairenimun.gov.np/
473	Devghat Rural Municipality	46	RURAL_MUNICIPALITY	159	http://www.devghatmun.gov.np/
474	Bandipur Rural Municipality	46	RURAL_MUNICIPALITY	102	http://www.bandipurmun.gov.np/
475	Rishing Rural Municipality	46	RURAL_MUNICIPALITY	215	http://www.rishingmun.gov.np/
476	Ghiring Rural Municipality	46	RURAL_MUNICIPALITY	126	http://www.ghiringmun.gov.np/
477	Myagde Rural Municipality	46	RURAL_MUNICIPALITY	115	http://www.myagdemun.gov.np/
478	Kapilvastu Municipality	47	MUNICIPALITY	136.91	http://www.kapilvastumun.gov.np/
479	Banganga Municipality	47	MUNICIPALITY	233.68	http://www.bangangamun.gov.np/
480	Buddhabhumi Municipality	47	MUNICIPALITY	366.67	http://www.buddhabhumimun.gov.np/
481	Shivaraj Municipality	47	MUNICIPALITY	284.07	http://www.shivrajmun.gov.np/
482	Krishnanagar Municipality	47	MUNICIPALITY	96.66	http://www.krishnanagarmun.gov.np/
483	Maharajgunj Municipality	47	MUNICIPALITY	112.21	http://www.maharajgunjmun.gov.np/
484	Mayadevi Rural Municipality	47	RURAL_MUNICIPALITY	88.53	http://www.mayadevimunkapilvastu.gov.np/
485	Yashodhara Rural Municipality	47	RURAL_MUNICIPALITY	67.56	http://www.yasodharamun.gov.np/
486	Suddhodan Rural Municipality	47	RURAL_MUNICIPALITY	91.69	http://www.shuddhodhanmunkapilvastu.gov.np/
487	Bijaynagar Rural Municipality	47	RURAL_MUNICIPALITY	173.19	http://www.bijaynagarmun.gov.np/
488	Bardaghat Municipality	48	MUNICIPALITY	162.05	http://www.bardghatmun.gov.np/
489	Ramgram Municipality	48	MUNICIPALITY	128.32	http://www.ramgrammun.gov.np/
490	Sunwal Municipality	48	MUNICIPALITY	139.1	http://www.sunwalmun.gov.np/
491	Susta Rural Municipality	48	RURAL_MUNICIPALITY	91.24	http://www.sustamun.gov.np/
492	Palhi Nandan Rural Municipality	48	RURAL_MUNICIPALITY	44.67	http://www.palhinandanmun.gov.np/
493	Pratappur Rural Municipality	48	RURAL_MUNICIPALITY	87.55	http://www.pratappurmun.gov.np/
494	Sarawal Rural Municipality	48	RURAL_MUNICIPALITY	73.19	http://www.sarawalmun.gov.np/
495	Butwal Sub-Metropolitan City	49	SUB_METROPOLITAN	101.61	http://www.butwalmun.gov.np/
496	Devdaha Municipality	49	MUNICIPALITY	136.95	http://www.devdahamun.gov.np/
497	Lumbini Sanskritik Municipality	49	MUNICIPALITY	112.21	http://www.lumbinisanskritikmun.gov.np/
498	Sainamaina Municipality	49	MUNICIPALITY	162.18	http://www.sainamainamun.gov.np/
499	Siddharthanagar Municipality	49	MUNICIPALITY	36.03	http://www.siddharthanagarmun.gov.np/
500	Tilottama Municipality	49	MUNICIPALITY	126.19	http://www.tilottamamun.gov.np/
501	Gaidahawa Rural Municipality	49	RURAL_MUNICIPALITY	96.79	http://www.gaidahawamun.gov.np/
502	Kanchan Rural Municipality	49	RURAL_MUNICIPALITY	58.51	http://www.kanchanmun.gov.np/
503	Kotahimai Rural Municipality	49	RURAL_MUNICIPALITY	58.26	http://www.kotahimaimun.gov.np/
504	Marchawari Rural Municipality	49	RURAL_MUNICIPALITY	48.55	http://www.marchawarimun.gov.np/
505	Mayadevi Rural Municipality	49	RURAL_MUNICIPALITY	72.44	http://www.mayadevimunrupandehi.gov.np/
506	Omsatiya Rural Municipality	49	RURAL_MUNICIPALITY	48.54	http://www.omsatiyamun.gov.np/
507	Rohini Rural Municipality	49	RURAL_MUNICIPALITY	64.62	http://www.rohinimun.gov.np/
508	Sammarimai Rural Municipality	49	RURAL_MUNICIPALITY	50.78	http://www.sammarimaimun.gov.np/
509	Siyari Rural Municipality	49	RURAL_MUNICIPALITY	66.17	http://www.siyarimun.gov.np/
510	Suddodhan Rural Municipality	49	RURAL_MUNICIPALITY	57.66	http://www.shuddhodhanmunrupandehi.gov.np/
511	Sandhikharka Municipality	50	MUNICIPALITY	129.42	http://www.sandhikharkamun.gov.np/
512	Sitganga Municipality	50	MUNICIPALITY	610.43	http://www.shitagangamun.gov.np/
513	Bhumikasthan Municipality	50	MUNICIPALITY	159.13	http://www.bhumikasthanmun.gov.np/
514	Chhatradev Rural Municipality	50	RURAL_MUNICIPALITY	87.62	http://www.chhatradevmun.gov.np/
515	Panini Rural Municipality	50	RURAL_MUNICIPALITY	151.42	http://www.paninimun.gov.np/
516	Malarani Rural Municipality	50	RURAL_MUNICIPALITY	101.06	http://www.malaranimun.gov.np/
517	Resunga Municipality	51	MUNICIPALITY	83.74	http://www.resungamun.gov.np/
518	Musikot Municipality	51	MUNICIPALITY	114.74	http://www.musikotmungulmi.gov.np/
519	Rurukshetra Rural Municipality	51	RURAL_MUNICIPALITY	67.38	http://www.rurumun.gov.np/
520	Chhatrakot Rural Municipality	51	RURAL_MUNICIPALITY	87.01	http://www.chhatrakotmun.gov.np/
521	Gulmidarbar Rural Municipality	51	RURAL_MUNICIPALITY	79.99	http://www.gulmidarbarmun.gov.np/
522	Chandrakot Rural Municipality	51	RURAL_MUNICIPALITY	105.73	http://www.chandrakotmun.gov.np/
523	Satyawati Rural Municipality	51	RURAL_MUNICIPALITY	115.92	http://www.satyawatimun.gov.np/
524	Dhurkot Rural Municipality	51	RURAL_MUNICIPALITY	86.32	http://www.dhurkotmun.gov.np/
525	Kaligandaki Rural Municipality	51	RURAL_MUNICIPALITY	101.04	http://www.kaligandakimungulmi.gov.np/
526	Isma Rural Municipality	51	RURAL_MUNICIPALITY	81.88	http://www.ishmamun.gov.np/
527	Malika Rural Municipality	51	RURAL_MUNICIPALITY	92.49	http://www.malikamungulmi.gov.np/
528	Madane Rural Municipality	51	RURAL_MUNICIPALITY	94.52	http://www.madanemun.gov.np/
529	Tansen Municipality	52	MUNICIPALITY	109.8	http://www.tansenmun.gov.np/
530	Rampur Municipality	52	MUNICIPALITY	123.34	http://www.rampurmun.gov.np/
531	Rainadevi Chhahara Rural Municipality	52	RURAL_MUNICIPALITY	175.78	http://www.rainadevichhaharamun.gov.np/
532	Ripdikot Rural Municipality	52	RURAL_MUNICIPALITY	124.55	http://www.ribdikotmun.gov.np/
533	Bagnaskali Rural Municipality	52	RURAL_MUNICIPALITY	84.17	http://www.baganaskalimun.gov.np/
534	Rambha Rural Municipality	52	RURAL_MUNICIPALITY	94.12	http://www.rambhamun.gov.np/
535	Purbakhola Rural Municipality	52	RURAL_MUNICIPALITY	138.05	http://www.purbakholamun.gov.np/
536	Nisdi Rural Municipality	52	RURAL_MUNICIPALITY	194.5	http://www.nisdimun.gov.np/
537	Mathagadhi Rural Municipality	52	RURAL_MUNICIPALITY	215.49	http://www.mathagadhimun.gov.np/
538	Tinahu Rural Municipality	52	RURAL_MUNICIPALITY	202	http://www.tinaumun.gov.np/
539	Ghorahi Sub-Metropolitan City	53	SUB_METROPOLITAN	522.21	http://www.ghorahimun.gov.np/
540	Tulsipur Sub-Metropolitan City	53	SUB_METROPOLITAN	384.63	http://www.tulsipurmun.gov.np/
541	Lamahi Municipality	53	MUNICIPALITY	326.66	http://www.lamahimun.gov.np/
542	Gadhawa Rural Municipality	53	RURAL_MUNICIPALITY	358.57	http://www.gadhawamun.gov.np/
543	Rajpur Rural Municipality	53	RURAL_MUNICIPALITY	577.33	http://www.rajpurmundang.gov.np/
544	Shantinagar Rural Municipality	53	RURAL_MUNICIPALITY	116.02	http://www.shantinagarmun.gov.np/
545	Rapti Rural Municipality	53	RURAL_MUNICIPALITY	161.07	http://www.raptimundang.gov.np/
546	Banglachuli Rural Municipality	53	RURAL_MUNICIPALITY	245.14	http://www.bangalachulimun.gov.np/
547	Dangisharan Rural Municipality	53	RURAL_MUNICIPALITY	110.7	http://www.dangisharanmun.gov.np/
548	Babai Rural Municipality	53	RURAL_MUNICIPALITY	257.48	http://www.babaimun.gov.np/
549	Sworgadwari Municipality	54	MUNICIPALITY	224.7	http://www.swargadwarimun.gov.np/
550	Pyuthan Municipality	54	MUNICIPALITY	128.96	http://www.pyuthanmun.gov.np/
551	Mandavi Rural Municipality	54	RURAL_MUNICIPALITY	113.08	http://www.mandavimun.gov.np/
552	Sarumarani Rural Municipality	54	RURAL_MUNICIPALITY	157.97	http://www.sarumaranimun.gov.np/
553	Ayirawati Rural Municipality	54	RURAL_MUNICIPALITY	156.75	http://www.airawatimun.gov.np/
554	Mallarani Rural Municipality	54	RURAL_MUNICIPALITY	80.09	http://www.mallaranimun.gov.np/
555	Jhimruk Rural Municipality	54	RURAL_MUNICIPALITY	106.93	http://www.jhimrukmun.gov.np/
556	Naubahini Rural Municipality	54	RURAL_MUNICIPALITY	213.41	http://www.naubahinimun.gov.np/
557	Gaumukhi Rural Municipality	54	RURAL_MUNICIPALITY	139.04	http://www.gaumukhimun.gov.np/
558	Rolpa Municipality	55	MUNICIPALITY	270.42	http://www.rolpamun.gov.np/
559	Runtigadi Rural Municipality	55	RURAL_MUNICIPALITY	232.69	http://www.runtigadhimun.gov.np/
560	Triveni Rural Municipality	55	RURAL_MUNICIPALITY	205.39	http://www.trivenimunrolpa.gov.np/
561	Sunil Smiriti Rural Municipality	55	RURAL_MUNICIPALITY	156.55	http://www.sunilsmritimun.gov.np/
562	Lungri Rural Municipality	55	RURAL_MUNICIPALITY	135.23	http://www.lungrimun.gov.np/
563	Sunchhahari Rural Municipality	55	RURAL_MUNICIPALITY	277.62	http://www.sunchhaharimun.gov.np/
564	Thawang Rural Municipality	55	RURAL_MUNICIPALITY	191.07	http://www.thabangmun.gov.np/
565	Madi Rural Municipality	55	RURAL_MUNICIPALITY	129.05	http://www.madimunrolpa.gov.np/
566	GangaDev Rural Municipality	55	RURAL_MUNICIPALITY	124.38	http://www.sukidahamun.gov.np/
567	Pariwartan Rural Municipality	55	RURAL_MUNICIPALITY	163.01	http://www.duikholimun.gov.np/
568	Putha Uttarganga Rural Municipality	56	RURAL_MUNICIPALITY	560.34	http://www.puthauttargangamun.gov.np/
569	Bhume Rural Municipality	56	RURAL_MUNICIPALITY	273.67	http://www.bhumemun.gov.np/
570	Sisne Rural Municipality	56	RURAL_MUNICIPALITY	327.12	http://www.sisnemun.gov.np/
571	Nepalgunj Sub-Metropolitan City	57	SUB_METROPOLITAN	85.94	http://www.nepalgunjmun.gov.np/
572	Kohalpur Municipality	57	MUNICIPALITY	184.26	http://www.kohalpurmun.gov.np/
573	Rapti-Sonari Rural Municipality	57	RURAL_MUNICIPALITY	1041.73	http://www.raptisonarimun.gov.np/
574	Narainapur Rural Municipality	57	RURAL_MUNICIPALITY	172.34	http://www.narainapurmun.gov.np/
575	Duduwa Rural Municipality	57	RURAL_MUNICIPALITY	91.1	http://www.duduwamun.gov.np/
576	Janaki Rural Municipality	57	RURAL_MUNICIPALITY	63.32	http://www.janakimunbanke.gov.np/
577	Khajura Rural Municipality	57	RURAL_MUNICIPALITY	101.91	http://www.khajuramun.gov.np/
578	Baijanath Rural Municipality	57	RURAL_MUNICIPALITY	141.67	http://www.baijanathmun.gov.np/
579	Gulariya Municipality	58	MUNICIPALITY	118.21	http://www.gulariyamun.gov.np/
580	Rajapur Municipality	58	MUNICIPALITY	127.08	http://www.rajapurmun.gov.np/
581	Madhuwan Municipality	58	MUNICIPALITY	129.73	http://www.madhuwanmun.gov.np/
582	Thakurbaba Municipality	58	MUNICIPALITY	104.57	http://www.thakurbabamun.gov.np/
583	Basgadhi Municipality	58	MUNICIPALITY	206.08	http://www.bansgadhimun.gov.np/
584	Barbardiya Municipality	58	MUNICIPALITY	226.09	http://www.barbardiyamun.gov.np/
585	Badhaiyatal Rural Municipality	58	RURAL_MUNICIPALITY	115.19	http://www.badhaiyatalmun.gov.np/
586	Geruwa Rural Municipality	58	RURAL_MUNICIPALITY	78.41	http://www.geruwamun.gov.np/
587	Aathabiskot Municipality	59	MUNICIPALITY	560.34	http://www.aathbiskotmun.gov.np/
588	Musikot Municipality	59	MUNICIPALITY	136.06	http://www.musikotmunrukum.gov.np/
589	Chaurjahari Municipality	59	MUNICIPALITY	107.38	http://www.chaurjaharimun.gov.np/
590	SaniBheri Rural Municipality	59	RURAL_MUNICIPALITY	133.8	http://www.sanibherimun.gov.np/
591	Triveni Rural Municipality	59	RURAL_MUNICIPALITY	85.49	http://www.trivenimunrukum.gov.np/
592	Banphikot Rural Municipality	59	RURAL_MUNICIPALITY	190.42	http://www.banphikotmun.gov.np/
593	Kumakh Rural Municipality	60	RURAL_MUNICIPALITY	177.28	http://www.kumakhmalikamun.gov.np/
594	Kalimati Rural Municipality	60	RURAL_MUNICIPALITY	500.72	http://www.kalimatimun.gov.np/
595	Chhatreshwari Rural Municipality	60	RURAL_MUNICIPALITY	150.69	http://www.chhatreshworimun.gov.np/
596	Darma Rural Municipality	60	RURAL_MUNICIPALITY	81.46	http://www.darmamun.gov.np/
597	Kapurkot Rural Municipality	60	RURAL_MUNICIPALITY	119.21	http://www.kapurkotmun.gov.np/
598	Triveni Rural Municipality	60	RURAL_MUNICIPALITY	119.11	http://www.trivenimunsalyan.gov.np/
599	Siddha Kumakh Rural Municipality	60	RURAL_MUNICIPALITY	89.36	http://www.siddhakumakhmun.gov.np/
600	Bagchaur Municipality	60	MUNICIPALITY	163.14	http://www.bagchaurmun.gov.np/
601	Shaarda Municipality	60	MUNICIPALITY	198.34	http://www.shaaradamun.gov.np/
602	Bangad Kupinde Municipality	60	MUNICIPALITY	338.21	http://www.bangadkupindemun.gov.np/
603	Mudkechula Rural Municipality	61	RURAL_MUNICIPALITY	250.08	http://www.mudkechulamun.gov.np/
604	Kaike Rural Municipality	61	RURAL_MUNICIPALITY	466.6	http://www.kaikemun.gov.np/
605	She Phoksundo Rural Municipality	61	RURAL_MUNICIPALITY	123.07	http://www.shephoksundomun.gov.np/
606	Jagadulla Rural Municipality	61	RURAL_MUNICIPALITY	83.31	http://www.jagdullamun.gov.np/
607	Dolpo Buddha Rural Municipality	61	RURAL_MUNICIPALITY	377.38	http://www.dolpobuddhamun.gov.np/
608	Chharka Tongsong Rural Municipality	61	RURAL_MUNICIPALITY	345.57	http://www.chharkatangsongmun.gov.np/
609	Thuli Bheri Municipality	61	MUNICIPALITY	421.34	http://www.thulibherimun.gov.np/
610	Tripurasundari Municipality	61	MUNICIPALITY	393.54	http://www.tripurasundarimundolpa.gov.np/
611	Simkot Rural Municipality	62	RURAL_MUNICIPALITY	785.89	http://www.simkotmun.gov.np/
612	Sarkegad Rural Municipality	62	RURAL_MUNICIPALITY	306.7	http://www.sarkegadmun.gov.np/
613	Adanchuli Rural Municipality	62	RURAL_MUNICIPALITY	150.61	http://www.adanchulimun.gov.np/
614	Kharpunath Rural Municipality	62	RURAL_MUNICIPALITY	880	http://www.kharpunathmun.gov.np/
615	Tanjakot Rural Municipality	62	RURAL_MUNICIPALITY	159.1	http://www.tajakotmun.gov.np/
616	Chankheli Rural Municipality	62	RURAL_MUNICIPALITY	1310.41	http://www.chankhelimun.gov.np/
617	Namkha Rural Municipality	62	RURAL_MUNICIPALITY	2419.64	http://www.namkhamun.gov.np/
618	Tatopani Rural Municipality	63	RURAL_MUNICIPALITY	525.56	http://www.tatopanimun.gov.np/
619	Patarasi Rural Municipality	63	RURAL_MUNICIPALITY	814.07	http://www.patarasimun.gov.np/
620	Tila Rural Municipality	63	RURAL_MUNICIPALITY	175.49	http://www.tilamun.gov.np/
621	Kanaka Sundari Rural Municipality	63	RURAL_MUNICIPALITY	225.39	http://www.kankasundarimun.gov.np/
622	Sinja Rural Municipality	63	RURAL_MUNICIPALITY	153.29	http://www.sinjamun.gov.np/
623	Hima Rural Municipality	63	RURAL_MUNICIPALITY	132.32	http://www.himamun.gov.np/
624	Guthichaur Rural Municipality	63	RURAL_MUNICIPALITY	427	http://www.guthichaurmun.gov.np/
625	Chandannath Municipality	63	MUNICIPALITY	102.03	http://www.chandannathmun.gov.np/
626	Khandachakra Municipality	64	MUNICIPALITY	133.29	http://www.khandachakramun.gov.np/
627	Raskot Municipality	64	MUNICIPALITY	59.73	http://www.raskotmun.gov.np/
628	Tilagufa Municipality	64	MUNICIPALITY	262.56	http://www.tilagufamun.gov.np/
629	Narharinath Rural Municipality	64	RURAL_MUNICIPALITY	143.86	http://www.narharinathmun.gov.np/
630	Palata Rural Municipality	64	RURAL_MUNICIPALITY	318.84	http://www.palatamun.gov.np/
631	Shubha Kalika Rural Municipality	64	RURAL_MUNICIPALITY	97.32	http://www.kalikamunkalikot.gov.np/
632	Sanni Triveni Rural Municipality	64	RURAL_MUNICIPALITY	136.71	http://www.sannitrivenimun.gov.np/
633	Pachaljharana Rural Municipality	64	RURAL_MUNICIPALITY	166.92	http://www.pachaljharanamun.gov.np/
634	Mahawai Rural Municipality	64	RURAL_MUNICIPALITY	322.07	http://www.mahawaimun.gov.np/
635	Khatyad Rural Municipality	65	RURAL_MUNICIPALITY	281.12	http://www.khatyadmun.gov.np/
636	Soru Rural Municipality	65	RURAL_MUNICIPALITY	365.8	http://www.sorumun.gov.np/
637	Mugum Karmarong Rural Municipality	65	RURAL_MUNICIPALITY	2106.91	http://www.mugumkarmarongmun.gov.np/
638	Chhayanath Rara Municipality	65	MUNICIPALITY	480.67	http://www.chhayanathraramun.gov.np/
639	Simta Rural Municipality	66	RURAL_MUNICIPALITY	241.64	http://www.simtamun.gov.np/
640	Barahatal Rural Municipality	66	RURAL_MUNICIPALITY	455.09	http://www.barahatalmun.gov.np/
641	Chaukune Rural Municipality	66	RURAL_MUNICIPALITY	381.01	http://www.chaukunemun.gov.np/
642	Chingad Rural Municipality	66	RURAL_MUNICIPALITY	170.19	http://www.chingadmun.gov.np/
643	Gurbhakot Municipality	66	MUNICIPALITY	228.62	http://www.gurbhakotmun.gov.np/
644	Birendranagar Municipality	66	MUNICIPALITY	245.06	http://www.birendranagarmun.gov.np/
645	Bheriganga Municipality	66	MUNICIPALITY	256.2	http://www.bherigangamun.gov.np/
646	Panchapuri Municipality	66	MUNICIPALITY	329.9	http://www.panchapurimun.gov.np/
647	Lekbeshi Municipality	66	MUNICIPALITY	180.92	http://www.lekbeshimun.gov.np/
648	Dullu Municipality	67	MUNICIPALITY	156.77	http://www.dullumun.gov.np/
649	Gurans Rural Municipality	67	RURAL_MUNICIPALITY	164.79	http://www.guransmun.gov.np/
650	Bhairabi Rural Municipality	67	RURAL_MUNICIPALITY	110.46	http://www.bhairabimun.gov.np/
651	Naumule Rural Municipality	67	RURAL_MUNICIPALITY	228.59	http://www.naumulemun.gov.np/
652	Mahabu Rural Municipality	67	RURAL_MUNICIPALITY	110.8	http://www.mahabumun.gov.np/
653	Thantikandh Rural Municipality	67	RURAL_MUNICIPALITY	88.22	http://www.thantikandhmun.gov.np/
654	Bhagawatimai Rural Municipality	67	RURAL_MUNICIPALITY	151.52	http://www.bhagawatimaimun.gov.np/
655	Dungeshwar Rural Municipality	67	RURAL_MUNICIPALITY	105.19	http://www.dungeshwormun.gov.np/
656	Aathabis Municipality	67	MUNICIPALITY	168	http://www.aathabismun.gov.np/
657	Narayan Municipality	67	MUNICIPALITY	110.63	http://www.narayanmun.gov.np/
658	Chamunda Bindrasaini Municipality	67	MUNICIPALITY	90.6	http://www.chamundabindrasainimun.gov.np/
659	Chhedagad Municipality	68	MUNICIPALITY	284.2	http://www.chhedagadmun.gov.np/
660	Bheri Municipality	68	MUNICIPALITY	219.77	http://www.bherimun.gov.np/
661	Nalgad Municipality	68	MUNICIPALITY	387.44	http://www.tribeninalgaadmun.gov.np/
662	Junichande Rural Municipality	68	RURAL_MUNICIPALITY	346.21	http://www.junichaandemun.gov.np/
663	Kuse Rural Municipality	68	RURAL_MUNICIPALITY	273.97	http://www.kushemun.gov.np/
664	Barekot Rural Municipality	68	RURAL_MUNICIPALITY	577.5	http://www.barekotmun.gov.np/
665	Shivalaya Rural Municipality	68	RURAL_MUNICIPALITY	134.26	http://www.shibalayamun.gov.np/
666	Mahakali Municipality	69	MUNICIPALITY	135.11	http://www.mahakalimundarchula.gov.np/
667	Shailyashikhar Municipality	69	MUNICIPALITY	117.81	http://www.shailyashikharmun.gov.np/
668	Naugad Rural Municipality	69	RURAL_MUNICIPALITY	180.27	http://www.naugadmun.gov.np/
669	Malikarjun Rural Municipality	69	RURAL_MUNICIPALITY	100.82	http://www.malikarjunmun.gov.np/
670	Marma Rural Municipality	69	RURAL_MUNICIPALITY	208.06	http://www.marmamun.gov.np/
671	Lekam Rural Municipality	69	RURAL_MUNICIPALITY	83.98	http://www.lekammun.gov.np/
672	Duhun Rural Municipality	69	RURAL_MUNICIPALITY	65.35	http://www.duhunmun.gov.np/
673	Vyans Rural Municipality	69	RURAL_MUNICIPALITY	839.26	http://www.vyansmun.gov.np/
674	Apihimal Rural Municipality	69	RURAL_MUNICIPALITY	613.95	http://www.apihimalmun.gov.np/
675	Jayaprithvi Municipality	70	MUNICIPALITY	166.79	http://www.jayaprithvimun.gov.np/
676	Bungal Municipality	70	MUNICIPALITY	447.59	http://www.bungalmun.gov.np/
677	Kedarsyu Rural Municipality	70	RURAL_MUNICIPALITY	113.91	http://www.kedarasyumun.gov.np/
678	Thalara Rural Municipality	70	RURAL_MUNICIPALITY	105.51	http://www.thalaramun.gov.np/
679	Bitthadchir Rural Municipality	70	RURAL_MUNICIPALITY	86.15	http://www.bitthadchirmun.gov.np/
680	Chhabis Pathibhera Rural Municipality	70	RURAL_MUNICIPALITY	116.34	http://www.chhabispathiveramun.gov.np/
681	Khaptadchhanna Rural Municipality	70	RURAL_MUNICIPALITY	113.52	http://www.khaptadchhannamun.gov.np/
682	Masta Rural Municipality	70	RURAL_MUNICIPALITY	109.24	http://www.mastamun.gov.np/
683	Durgathali Rural Municipality	70	RURAL_MUNICIPALITY	61.83	http://www.durgathalimun.gov.np/
684	Talkot Rural Municipality	70	RURAL_MUNICIPALITY	335.26	http://www.talkotmun.gov.np/
685	Surma Rural Municipality	70	RURAL_MUNICIPALITY	270.8	http://www.surmamun.gov.np/
686	Saipal Rural Municipality	70	RURAL_MUNICIPALITY	1467.27	http://www.kandamun.gov.np/
687	Badimalika Municipality	71	MUNICIPALITY	276	http://www.badimalikamun.gov.np/
688	Triveni Municipality	71	MUNICIPALITY	170.32	http://www.trivenimunbajura.gov.np/
689	Budhiganga Municipality	71	MUNICIPALITY	59.2	http://www.budhigangamunbajura.gov.np/
690	Budhinanda Municipality	71	MUNICIPALITY	232.48	http://www.budhinandamun.gov.np/
691	Khaptad Chhededaha Rural Municipality	71	RURAL_MUNICIPALITY	135.08	http://www.chhededahamun.gov.np/
692	Swami Kartik Khapar Rural Municipality	71	RURAL_MUNICIPALITY	110.55	http://www.swamikartikmun.gov.np/
693	Jagannath Rural Municipality	71	RURAL_MUNICIPALITY	171.72	http://www.jagganathmun.gov.np/
694	Himali Rural Municipality	71	RURAL_MUNICIPALITY	830.33	http://www.himalimun.gov.np/
695	Gaumul Rural Municipality	71	RURAL_MUNICIPALITY	314.66	http://www.gaumulmun.gov.np/
696	Dashrathchanda Municipality	72	MUNICIPALITY	135.15	http://www.dasharathchandmun.gov.np/
697	Patan Municipality	72	MUNICIPALITY	219.26	http://www.patanmun.gov.np/
698	Melauli Municipality	72	MUNICIPALITY	119.43	http://www.melaulimun.gov.np/
699	Purchaudi Municipality	72	MUNICIPALITY	198.52	http://www.purchaudimun.gov.np/
700	Dogdakedar Rural Municipality	72	RURAL_MUNICIPALITY	126.38	http://www.dogdakedarmun.gov.np/
701	Dilashaini Rural Municipality	72	RURAL_MUNICIPALITY	125.28	http://www.dilasainimun.gov.np/
702	Sigas Rural Municipality	72	RURAL_MUNICIPALITY	245.44	http://www.sigasmun.gov.np/
703	Pancheshwar Rural Municipality	72	RURAL_MUNICIPALITY	120.41	http://www.pancheshwormun.gov.np/
704	Surnaya Rural Municipality	72	RURAL_MUNICIPALITY	124.52	http://www.sunaryamun.gov.np/
705	Shivanath Rural Municipality	72	RURAL_MUNICIPALITY	81.65	http://www.shivanathmun.gov.np/
706	Dipayal Silgadhi Municipality	73	MUNICIPALITY	162.62	http://www.dipayalsilgadhimun.gov.np/
707	Shikhar Municipality	73	MUNICIPALITY	585.37	http://www.shikharmun.gov.np/
708	Aadarsha Rural Municipality	73	RURAL_MUNICIPALITY	128.47	http://www.aadarshamun.gov.np/
709	Purbichauki Rural Municipality	73	RURAL_MUNICIPALITY	117.66	http://www.purbichaukimun.gov.np/
710	K.I.Singh Rural Municipality	73	RURAL_MUNICIPALITY	127.01	http://www.kisinghmun.gov.np/
711	Jorayal Rural Municipality	73	RURAL_MUNICIPALITY	419.09	http://www.jorayalmun.gov.np/
712	Sayal Rural Municipality	73	RURAL_MUNICIPALITY	122.72	http://www.sayalmun.gov.np/
713	Bogatan-Phudsil Rural Municipality	73	RURAL_MUNICIPALITY	300.22	http://www.bogatanmun.gov.np/
714	Badikedar Rural Municipality	73	RURAL_MUNICIPALITY	332.55	http://www.badikedarmun.gov.np/
715	Ramaroshan Rural Municipality	74	RURAL_MUNICIPALITY	173.33	http://www.ramaroshanmun.gov.np/
716	Chaurpati Rural Municipality	74	RURAL_MUNICIPALITY	182.16	http://www.chaurpatimun.gov.np/
717	Turmakhand Rural Municipality	74	RURAL_MUNICIPALITY	232.07	http://www.turmakhadmun.gov.np/
718	Mellekh Rural Municipality	74	RURAL_MUNICIPALITY	134.78	http://www.mellekhmun.gov.np/
719	Dhakari Rural Municipality	74	RURAL_MUNICIPALITY	227.88	http://www.dhakarimun.gov.np/
720	Bannigadi Jayagad Rural Municipality	74	RURAL_MUNICIPALITY	58.26	http://www.bannigadhijaygadhmun.gov.np/
721	Mangalsen Municipality	74	MUNICIPALITY	220.14	http://www.mangalsenmun.gov.np/
722	Kamalbazar Municipality	74	MUNICIPALITY	120.78	http://www.kamalbazarmun.gov.np/
723	Sanfebagar Municipality	74	MUNICIPALITY	166.71	http://www.sanfebagarmun.gov.np/
724	Panchadewal Binayak Municipality	74	MUNICIPALITY	147.75	http://www.panchadewalbinayakmun.gov.np/
725	Navadurga Rural Municipality	75	RURAL_MUNICIPALITY	141.89	http://www.navadurgamun.gov.np/
726	Aalitaal Rural Municipality	75	RURAL_MUNICIPALITY	292.87	http://www.aalitalmun.gov.np/
727	Ganyapadhura Rural Municipality	75	RURAL_MUNICIPALITY	135.65	http://www.ganyapadhuramun.gov.np/
728	Bhageshwar Rural Municipality	75	RURAL_MUNICIPALITY	233.38	http://www.bhageshwormun.gov.np/
729	Ajaymeru Rural Municipality	75	RURAL_MUNICIPALITY	148.9	http://www.ajayamerumun.gov.np/
730	Amargadhi Municipality	75	MUNICIPALITY	139.33	http://www.amargadhimun.gov.np/
731	Parshuram Municipality	75	MUNICIPALITY	414.07	http://www.parshurammun.gov.np/
732	Bhimdatta Municipality	76	MUNICIPALITY	171.8	http://www.bheemdattamun.gov.np/
733	Punarbas Municipality	76	MUNICIPALITY	103.71	http://www.punarbasmun.gov.np/
734	Bedkot Municipality	76	MUNICIPALITY	159.92	http://www.bedkotmun.gov.np/
735	Mahakali Municipality	76	MUNICIPALITY	56.84	https://mahakalimunkanchanpur.gov.np/
736	Shuklaphanta Municipality	76	MUNICIPALITY	162.57	http://www.shuklaphantamun.gov.np/
737	Belauri Municipality	76	MUNICIPALITY	123.37	http://www.belaurimun.gov.np/
738	Krishnapur Municipality	76	MUNICIPALITY	252.75	http://www.krishnapurmun.gov.np/
739	Laljhadi Rural Municipality	76	RURAL_MUNICIPALITY	154.65	http://www.laljhadimun.gov.np/
740	Beldandi Rural Municipality	76	RURAL_MUNICIPALITY	36.7	http://www.beldandimun.gov.np/
741	Janaki Rural Municipality	77	RURAL_MUNICIPALITY	107.27	http://www.janakimunkailali.gov.np/
742	Kailari Rural Municipality	77	RURAL_MUNICIPALITY	233.27	http://www.kailarimun.gov.np/
743	Joshipur Rural Municipality	77	RURAL_MUNICIPALITY	65.57	http://www.joshipurmun.gov.np/
744	Bardagoriya Rural Municipality	77	RURAL_MUNICIPALITY	77.26	http://www.bardgoriyamun.gov.np/
745	Mohanyal Rural Municipality	77	RURAL_MUNICIPALITY	626.95	http://www.mohanyalmun.gov.np/
746	Chure Rural Municipality	77	RURAL_MUNICIPALITY	493.18	http://www.churemun.gov.np/
747	Tikapur Municipality	77	MUNICIPALITY	118.33	http://www.tikapurmun.gov.np/
748	Ghodaghodi Municipality	77	MUNICIPALITY	354.45	http://www.ghodaghodimun.gov.np/
749	Lamkichuha Municipality	77	MUNICIPALITY	225	http://www.lamkichuhamun.gov.np/
750	Bhajni Municipality	77	MUNICIPALITY	176.25	http://www.bhajanimun.gov.np/
751	Godawari Municipality	77	MUNICIPALITY	308.63	http://www.godawarimunkailali.gov.np/
752	Gauriganga Municipality	77	MUNICIPALITY	244.44	http://www.gaurigangamun.gov.np/
753	Dhangadhi Sub-Metropolitan City	77	SUB_METROPOLITAN	261.75	http://www.dhangadhimun.gov.np/
\.


--
-- Data for Name: political_experiences; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.political_experiences (id, candidate_details_id, title, description, image_url, year) FROM stdin;
8	2	Ward Chairperson - Kathmandu Ward 5	Served as Ward Chairperson focusing on infrastructure and sanitation improvements.	\N	2017
9	2	Member of City Development Committee	Worked on urban development and smart city planning initiatives.	\N	2020
10	1	dasad	dasdadas	\N	2000
11	3	sfsfsf	fsfd	\N	1000
\.


--
-- Data for Name: positive_contributions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.positive_contributions (id, candidate_details_id, title, description, image_url, date, impact) FROM stdin;
1	1	Community Library	Built a public library	\N	2023-05-01 00:00:00	High
2	2	Community Clean-up Drive	Organized neighborhood sanitation and clean-up campaigns.	\N	2022-03-15 00:00:00	Improved public health and hygiene.
3	2	Scholarship Program	Provided scholarships for underprivileged students.	\N	2021-09-01 00:00:00	Supported 50+ students in continuing education.
\.


--
-- Data for Name: province; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.province (id, name, area_sq_km, website, headquarter, country_id, created_at, updated_at) FROM stdin;
1	Koshi Province	25906	https://koshi.gov.np/	Biratnagar	1	2025-09-30 07:15:34.390217+00	2025-09-30 07:15:34.390217+00
2	Madhesh Province	9661	https://madhesh.gov.np/	Janakpur	1	2025-09-30 07:18:14.741543+00	2025-09-30 07:18:14.741543+00
3	Bagmati	20300	https://ocmcm.bagamati.gov.np/	Hetauda	1	2025-09-30 07:19:39.964137+00	2025-09-30 07:19:39.964137+00
4	Gandaki	21856	https://gandaki.gov.np/	Pokhara	1	2025-09-30 07:19:40.018369+00	2025-09-30 07:19:40.018369+00
5	Lumbini	19707	https://ocmcm.lumbini.gov.np/	Deukhuri	1	2025-09-30 07:19:40.024747+00	2025-09-30 07:19:40.024747+00
6	Karnali	30213	https://karnali.gov.np/	Birendranagar	1	2025-09-30 07:19:40.031177+00	2025-09-30 07:19:40.031177+00
7	Sudur Paschimanchal	19539	https://sudurpashchim.gov.np/	Godawari	1	2025-09-30 07:19:40.036766+00	2025-09-30 07:19:40.036766+00
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (id, name, email, password) FROM stdin;
1	string	user@example.com	$2b$12$1E/8gr0t0s7e0JuqenpfD.2TFC05IfaGPal1R8nhFOd9FEVzS28q6
2	string	use22r@example.com	$2b$12$Dyf4WOJlSrpwTyKqFCvVaeHcsNEzCccmjvnJOrXDp/lKiJudHHiHu
35	san	san@gmail.com	$2b$12$wtsdX.R1qo3YLFGpSLbK1ulkPlZGQNVx1Pm1EnyUYPymQO2S.FIlK
\.


--
-- Data for Name: wards; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.wards (id, name, number, municipality_id) FROM stdin;
1	Ward 1	1	1
2	Ward 2	2	1
3	Ward 3	3	1
4	Ward 4	4	1
5	Ward 5	5	1
6	Ward 6	6	1
7	Ward 7	7	1
8	Ward 8	8	1
9	Ward 9	9	1
10	Ward 10	10	1
11	Ward 11	11	1
12	Ward 12	12	1
13	Ward 13	13	1
14	Ward 14	14	1
15	Ward 1	1	2
16	Ward 2	2	2
17	Ward 3	3	2
18	Ward 4	4	2
19	Ward 5	5	2
20	Ward 6	6	2
21	Ward 7	7	2
22	Ward 8	8	2
23	Ward 9	9	2
24	Ward 10	10	2
25	Ward 11	11	2
26	Ward 12	12	2
27	Ward 1	1	3
28	Ward 2	2	3
29	Ward 3	3	3
30	Ward 4	4	3
31	Ward 5	5	3
32	Ward 6	6	3
33	Ward 7	7	3
34	Ward 8	8	3
35	Ward 9	9	3
36	Ward 1	1	4
37	Ward 2	2	4
38	Ward 3	3	4
39	Ward 4	4	4
40	Ward 5	5	4
41	Ward 6	6	4
42	Ward 7	7	4
43	Ward 8	8	4
44	Ward 1	1	5
45	Ward 2	2	5
46	Ward 3	3	5
47	Ward 4	4	5
48	Ward 5	5	5
49	Ward 6	6	5
50	Ward 7	7	5
51	Ward 8	8	5
52	Ward 9	9	5
53	Ward 10	10	5
54	Ward 1	1	6
55	Ward 2	2	6
56	Ward 3	3	6
57	Ward 4	4	6
58	Ward 5	5	6
59	Ward 6	6	6
60	Ward 7	7	6
61	Ward 8	8	6
62	Ward 9	9	6
63	Ward 1	1	7
64	Ward 2	2	7
65	Ward 3	3	7
66	Ward 4	4	7
67	Ward 5	5	7
68	Ward 6	6	7
69	Ward 7	7	7
70	Ward 1	1	8
71	Ward 2	2	8
72	Ward 3	3	8
73	Ward 4	4	8
74	Ward 5	5	8
75	Ward 6	6	8
76	Ward 1	1	9
77	Ward 2	2	9
78	Ward 3	3	9
79	Ward 4	4	9
80	Ward 5	5	9
81	Ward 6	6	9
82	Ward 1	1	10
83	Ward 2	2	10
84	Ward 3	3	10
85	Ward 4	4	10
86	Ward 5	5	10
87	Ward 6	6	10
88	Ward 7	7	10
89	Ward 8	8	10
90	Ward 9	9	10
91	Ward 10	10	10
92	Ward 1	1	11
93	Ward 2	2	11
94	Ward 3	3	11
95	Ward 4	4	11
96	Ward 5	5	11
97	Ward 6	6	11
98	Ward 7	7	11
99	Ward 8	8	11
100	Ward 9	9	11
101	Ward 10	10	11
102	Ward 1	1	12
103	Ward 2	2	12
104	Ward 3	3	12
105	Ward 4	4	12
106	Ward 5	5	12
107	Ward 6	6	12
108	Ward 7	7	12
109	Ward 8	8	12
110	Ward 9	9	12
111	Ward 1	1	13
112	Ward 2	2	13
113	Ward 3	3	13
114	Ward 4	4	13
115	Ward 5	5	13
116	Ward 6	6	13
117	Ward 7	7	13
118	Ward 8	8	13
119	Ward 9	9	13
120	Ward 10	10	13
121	Ward 1	1	14
122	Ward 2	2	14
123	Ward 3	3	14
124	Ward 4	4	14
125	Ward 5	5	14
126	Ward 6	6	14
127	Ward 7	7	14
128	Ward 8	8	14
129	Ward 1	1	15
130	Ward 2	2	15
131	Ward 3	3	15
132	Ward 4	4	15
133	Ward 5	5	15
134	Ward 6	6	15
135	Ward 7	7	15
136	Ward 1	1	16
137	Ward 2	2	16
138	Ward 3	3	16
139	Ward 4	4	16
140	Ward 5	5	16
141	Ward 6	6	16
142	Ward 1	1	17
143	Ward 2	2	17
144	Ward 3	3	17
145	Ward 4	4	17
146	Ward 5	5	17
147	Ward 6	6	17
148	Ward 7	7	17
149	Ward 8	8	17
150	Ward 9	9	17
151	Ward 10	10	17
152	Ward 11	11	17
153	Ward 12	12	17
154	Ward 13	13	17
155	Ward 14	14	17
156	Ward 1	1	18
157	Ward 2	2	18
158	Ward 3	3	18
159	Ward 4	4	18
160	Ward 5	5	18
161	Ward 6	6	18
162	Ward 7	7	18
163	Ward 8	8	18
164	Ward 9	9	18
165	Ward 10	10	18
166	Ward 11	11	18
167	Ward 12	12	18
168	Ward 1	1	19
169	Ward 2	2	19
170	Ward 3	3	19
171	Ward 4	4	19
172	Ward 5	5	19
173	Ward 6	6	19
174	Ward 7	7	19
175	Ward 8	8	19
176	Ward 9	9	19
177	Ward 1	1	20
178	Ward 2	2	20
179	Ward 3	3	20
180	Ward 4	4	20
181	Ward 5	5	20
182	Ward 6	6	20
183	Ward 1	1	21
184	Ward 2	2	21
185	Ward 3	3	21
186	Ward 4	4	21
187	Ward 5	5	21
188	Ward 6	6	21
189	Ward 7	7	21
190	Ward 1	1	22
191	Ward 2	2	22
192	Ward 3	3	22
193	Ward 4	4	22
194	Ward 5	5	22
195	Ward 6	6	22
196	Ward 7	7	22
197	Ward 8	8	22
198	Ward 9	9	22
199	Ward 10	10	22
200	Ward 1	1	23
201	Ward 2	2	23
202	Ward 3	3	23
203	Ward 4	4	23
204	Ward 5	5	23
205	Ward 6	6	23
206	Ward 1	1	24
207	Ward 2	2	24
208	Ward 3	3	24
209	Ward 4	4	24
210	Ward 5	5	24
211	Ward 6	6	24
212	Ward 1	1	25
213	Ward 2	2	25
214	Ward 3	3	25
215	Ward 4	4	25
216	Ward 5	5	25
217	Ward 6	6	25
218	Ward 1	1	26
219	Ward 2	2	26
220	Ward 3	3	26
221	Ward 4	4	26
222	Ward 5	5	26
223	Ward 1	1	27
224	Ward 2	2	27
225	Ward 3	3	27
226	Ward 4	4	27
227	Ward 5	5	27
228	Ward 6	6	27
229	Ward 7	7	27
230	Ward 8	8	27
231	Ward 9	9	27
232	Ward 10	10	27
233	Ward 11	11	27
234	Ward 12	12	27
235	Ward 13	13	27
236	Ward 14	14	27
237	Ward 15	15	27
238	Ward 1	1	28
239	Ward 2	2	28
240	Ward 3	3	28
241	Ward 4	4	28
242	Ward 5	5	28
243	Ward 6	6	28
244	Ward 7	7	28
245	Ward 8	8	28
246	Ward 9	9	28
247	Ward 10	10	28
248	Ward 1	1	29
249	Ward 2	2	29
250	Ward 3	3	29
251	Ward 4	4	29
252	Ward 5	5	29
253	Ward 6	6	29
254	Ward 7	7	29
255	Ward 8	8	29
256	Ward 9	9	29
257	Ward 10	10	29
258	Ward 1	1	30
259	Ward 2	2	30
260	Ward 3	3	30
261	Ward 4	4	30
262	Ward 5	5	30
263	Ward 6	6	30
264	Ward 7	7	30
265	Ward 8	8	30
266	Ward 9	9	30
267	Ward 10	10	30
268	Ward 1	1	31
269	Ward 2	2	31
270	Ward 3	3	31
271	Ward 4	4	31
272	Ward 5	5	31
273	Ward 6	6	31
274	Ward 7	7	31
275	Ward 8	8	31
276	Ward 9	9	31
277	Ward 10	10	31
278	Ward 11	11	31
279	Ward 1	1	32
280	Ward 2	2	32
281	Ward 3	3	32
282	Ward 4	4	32
283	Ward 5	5	32
284	Ward 6	6	32
285	Ward 7	7	32
286	Ward 8	8	32
287	Ward 9	9	32
288	Ward 10	10	32
289	Ward 11	11	32
290	Ward 1	1	33
291	Ward 2	2	33
292	Ward 3	3	33
293	Ward 4	4	33
294	Ward 5	5	33
295	Ward 6	6	33
296	Ward 7	7	33
297	Ward 8	8	33
298	Ward 9	9	33
299	Ward 1	1	34
300	Ward 2	2	34
301	Ward 3	3	34
302	Ward 4	4	34
303	Ward 5	5	34
304	Ward 6	6	34
305	Ward 7	7	34
306	Ward 8	8	34
307	Ward 9	9	34
308	Ward 1	1	35
309	Ward 2	2	35
310	Ward 3	3	35
311	Ward 4	4	35
312	Ward 5	5	35
313	Ward 6	6	35
314	Ward 7	7	35
315	Ward 1	1	36
316	Ward 2	2	36
317	Ward 3	3	36
318	Ward 4	4	36
319	Ward 5	5	36
320	Ward 6	6	36
321	Ward 7	7	36
322	Ward 1	1	37
323	Ward 2	2	37
324	Ward 3	3	37
325	Ward 4	4	37
326	Ward 5	5	37
327	Ward 6	6	37
328	Ward 7	7	37
329	Ward 1	1	38
330	Ward 2	2	38
331	Ward 3	3	38
332	Ward 4	4	38
333	Ward 5	5	38
334	Ward 6	6	38
335	Ward 7	7	38
336	Ward 1	1	39
337	Ward 2	2	39
338	Ward 3	3	39
339	Ward 4	4	39
340	Ward 5	5	39
341	Ward 6	6	39
342	Ward 7	7	39
343	Ward 1	1	40
344	Ward 2	2	40
345	Ward 3	3	40
346	Ward 4	4	40
347	Ward 5	5	40
348	Ward 6	6	40
349	Ward 1	1	41
350	Ward 2	2	41
351	Ward 3	3	41
352	Ward 4	4	41
353	Ward 5	5	41
354	Ward 1	1	42
355	Ward 2	2	42
356	Ward 3	3	42
357	Ward 4	4	42
358	Ward 5	5	42
359	Ward 6	6	42
360	Ward 7	7	42
361	Ward 8	8	42
362	Ward 9	9	42
363	Ward 10	10	42
364	Ward 11	11	42
365	Ward 12	12	42
366	Ward 13	13	42
367	Ward 14	14	42
368	Ward 15	15	42
369	Ward 1	1	43
370	Ward 2	2	43
371	Ward 3	3	43
372	Ward 4	4	43
373	Ward 5	5	43
374	Ward 6	6	43
375	Ward 7	7	43
376	Ward 8	8	43
377	Ward 9	9	43
378	Ward 10	10	43
379	Ward 11	11	43
380	Ward 1	1	44
381	Ward 2	2	44
382	Ward 3	3	44
383	Ward 4	4	44
384	Ward 5	5	44
385	Ward 6	6	44
386	Ward 7	7	44
387	Ward 8	8	44
388	Ward 9	9	44
389	Ward 1	1	45
390	Ward 2	2	45
391	Ward 3	3	45
392	Ward 4	4	45
393	Ward 5	5	45
394	Ward 6	6	45
395	Ward 7	7	45
396	Ward 1	1	46
397	Ward 2	2	46
398	Ward 3	3	46
399	Ward 4	4	46
400	Ward 5	5	46
401	Ward 6	6	46
402	Ward 7	7	46
403	Ward 1	1	47
404	Ward 2	2	47
405	Ward 3	3	47
406	Ward 4	4	47
407	Ward 5	5	47
408	Ward 6	6	47
409	Ward 1	1	48
410	Ward 2	2	48
411	Ward 3	3	48
412	Ward 4	4	48
413	Ward 5	5	48
414	Ward 6	6	48
415	Ward 7	7	48
416	Ward 1	1	49
417	Ward 2	2	49
418	Ward 3	3	49
419	Ward 4	4	49
420	Ward 5	5	49
421	Ward 6	6	49
422	Ward 1	1	50
423	Ward 2	2	50
424	Ward 3	3	50
425	Ward 4	4	50
426	Ward 5	5	50
427	Ward 6	6	50
428	Ward 1	1	51
429	Ward 2	2	51
430	Ward 3	3	51
431	Ward 4	4	51
432	Ward 5	5	51
433	Ward 1	1	52
434	Ward 2	2	52
435	Ward 3	3	52
436	Ward 4	4	52
437	Ward 5	5	52
438	Ward 6	6	52
439	Ward 7	7	52
440	Ward 8	8	52
441	Ward 9	9	52
442	Ward 10	10	52
443	Ward 11	11	52
444	Ward 12	12	52
445	Ward 1	1	53
446	Ward 2	2	53
447	Ward 3	3	53
448	Ward 4	4	53
449	Ward 5	5	53
450	Ward 6	6	53
451	Ward 7	7	53
452	Ward 8	8	53
453	Ward 9	9	53
454	Ward 10	10	53
455	Ward 11	11	53
456	Ward 1	1	54
457	Ward 2	2	54
458	Ward 3	3	54
459	Ward 4	4	54
460	Ward 5	5	54
461	Ward 6	6	54
462	Ward 7	7	54
463	Ward 8	8	54
464	Ward 9	9	54
465	Ward 10	10	54
466	Ward 1	1	55
467	Ward 2	2	55
468	Ward 3	3	55
469	Ward 4	4	55
470	Ward 5	5	55
471	Ward 6	6	55
472	Ward 7	7	55
473	Ward 8	8	55
474	Ward 9	9	55
475	Ward 10	10	55
476	Ward 1	1	56
477	Ward 2	2	56
478	Ward 3	3	56
479	Ward 4	4	56
480	Ward 5	5	56
481	Ward 6	6	56
482	Ward 7	7	56
483	Ward 8	8	56
484	Ward 9	9	56
485	Ward 1	1	57
486	Ward 2	2	57
487	Ward 3	3	57
488	Ward 4	4	57
489	Ward 5	5	57
490	Ward 6	6	57
491	Ward 7	7	57
492	Ward 8	8	57
493	Ward 9	9	57
494	Ward 1	1	58
495	Ward 2	2	58
496	Ward 3	3	58
497	Ward 4	4	58
498	Ward 5	5	58
499	Ward 6	6	58
500	Ward 7	7	58
501	Ward 8	8	58
502	Ward 9	9	58
503	Ward 1	1	59
504	Ward 2	2	59
505	Ward 3	3	59
506	Ward 4	4	59
507	Ward 5	5	59
508	Ward 6	6	59
509	Ward 7	7	59
510	Ward 8	8	59
511	Ward 9	9	59
512	Ward 1	1	60
513	Ward 2	2	60
514	Ward 3	3	60
515	Ward 4	4	60
516	Ward 5	5	60
517	Ward 6	6	60
518	Ward 7	7	60
519	Ward 8	8	60
520	Ward 9	9	60
521	Ward 10	10	60
522	Ward 11	11	60
523	Ward 12	12	60
524	Ward 13	13	60
525	Ward 14	14	60
526	Ward 15	15	60
527	Ward 16	16	60
528	Ward 17	17	60
529	Ward 18	18	60
530	Ward 19	19	60
531	Ward 1	1	61
532	Ward 2	2	61
533	Ward 3	3	61
534	Ward 4	4	61
535	Ward 5	5	61
536	Ward 6	6	61
537	Ward 7	7	61
538	Ward 1	1	62
539	Ward 2	2	62
540	Ward 3	3	62
541	Ward 4	4	62
542	Ward 5	5	62
543	Ward 6	6	62
544	Ward 7	7	62
545	Ward 1	1	63
546	Ward 2	2	63
547	Ward 3	3	63
548	Ward 4	4	63
549	Ward 5	5	63
550	Ward 6	6	63
551	Ward 7	7	63
552	Ward 1	1	64
553	Ward 2	2	64
554	Ward 3	3	64
555	Ward 4	4	64
556	Ward 5	5	64
557	Ward 6	6	64
558	Ward 7	7	64
559	Ward 1	1	65
560	Ward 2	2	65
561	Ward 3	3	65
562	Ward 4	4	65
563	Ward 5	5	65
564	Ward 6	6	65
565	Ward 7	7	65
566	Ward 1	1	66
567	Ward 2	2	66
568	Ward 3	3	66
569	Ward 4	4	66
570	Ward 5	5	66
571	Ward 6	6	66
572	Ward 7	7	66
573	Ward 1	1	67
574	Ward 2	2	67
575	Ward 3	3	67
576	Ward 4	4	67
577	Ward 5	5	67
578	Ward 6	6	67
579	Ward 7	7	67
580	Ward 8	8	67
581	Ward 9	9	67
582	Ward 10	10	67
583	Ward 1	1	68
584	Ward 2	2	68
585	Ward 3	3	68
586	Ward 4	4	68
587	Ward 5	5	68
588	Ward 6	6	68
589	Ward 7	7	68
590	Ward 8	8	68
591	Ward 9	9	68
592	Ward 1	1	69
593	Ward 2	2	69
594	Ward 3	3	69
595	Ward 4	4	69
596	Ward 5	5	69
597	Ward 6	6	69
598	Ward 7	7	69
599	Ward 8	8	69
600	Ward 9	9	69
601	Ward 10	10	69
602	Ward 11	11	69
603	Ward 12	12	69
604	Ward 1	1	70
605	Ward 2	2	70
606	Ward 3	3	70
607	Ward 4	4	70
608	Ward 5	5	70
609	Ward 6	6	70
610	Ward 7	7	70
611	Ward 8	8	70
612	Ward 9	9	70
613	Ward 1	1	71
614	Ward 2	2	71
615	Ward 3	3	71
616	Ward 4	4	71
617	Ward 5	5	71
618	Ward 6	6	71
619	Ward 7	7	71
620	Ward 8	8	71
621	Ward 1	1	72
622	Ward 2	2	72
623	Ward 3	3	72
624	Ward 4	4	72
625	Ward 5	5	72
626	Ward 6	6	72
627	Ward 7	7	72
628	Ward 8	8	72
629	Ward 1	1	73
630	Ward 2	2	73
631	Ward 3	3	73
632	Ward 4	4	73
633	Ward 5	5	73
634	Ward 6	6	73
635	Ward 7	7	73
636	Ward 8	8	73
637	Ward 9	9	73
638	Ward 10	10	73
639	Ward 1	1	74
640	Ward 2	2	74
641	Ward 3	3	74
642	Ward 4	4	74
643	Ward 5	5	74
644	Ward 6	6	74
645	Ward 7	7	74
646	Ward 8	8	74
647	Ward 9	9	74
648	Ward 10	10	74
649	Ward 1	1	75
650	Ward 2	2	75
651	Ward 3	3	75
652	Ward 4	4	75
653	Ward 5	5	75
654	Ward 6	6	75
655	Ward 7	7	75
656	Ward 8	8	75
657	Ward 9	9	75
658	Ward 1	1	76
659	Ward 2	2	76
660	Ward 3	3	76
661	Ward 4	4	76
662	Ward 5	5	76
663	Ward 6	6	76
664	Ward 7	7	76
665	Ward 8	8	76
666	Ward 9	9	76
667	Ward 1	1	77
668	Ward 2	2	77
669	Ward 3	3	77
670	Ward 4	4	77
671	Ward 5	5	77
672	Ward 6	6	77
673	Ward 7	7	77
674	Ward 8	8	77
675	Ward 9	9	77
676	Ward 10	10	77
677	Ward 11	11	77
678	Ward 12	12	77
679	Ward 13	13	77
680	Ward 14	14	77
681	Ward 1	1	78
682	Ward 2	2	78
683	Ward 3	3	78
684	Ward 4	4	78
685	Ward 5	5	78
686	Ward 6	6	78
687	Ward 7	7	78
688	Ward 8	8	78
689	Ward 1	1	79
690	Ward 2	2	79
691	Ward 3	3	79
692	Ward 4	4	79
693	Ward 5	5	79
694	Ward 6	6	79
695	Ward 7	7	79
696	Ward 1	1	80
697	Ward 2	2	80
698	Ward 3	3	80
699	Ward 4	4	80
700	Ward 5	5	80
701	Ward 6	6	80
702	Ward 7	7	80
703	Ward 1	1	81
704	Ward 2	2	81
705	Ward 3	3	81
706	Ward 4	4	81
707	Ward 5	5	81
708	Ward 6	6	81
709	Ward 7	7	81
710	Ward 8	8	81
711	Ward 1	1	82
712	Ward 2	2	82
713	Ward 3	3	82
714	Ward 4	4	82
715	Ward 5	5	82
716	Ward 6	6	82
717	Ward 1	1	83
718	Ward 2	2	83
719	Ward 3	3	83
720	Ward 4	4	83
721	Ward 5	5	83
722	Ward 1	1	84
723	Ward 2	2	84
724	Ward 3	3	84
725	Ward 4	4	84
726	Ward 5	5	84
727	Ward 1	1	85
728	Ward 2	2	85
729	Ward 3	3	85
730	Ward 4	4	85
731	Ward 5	5	85
732	Ward 6	6	85
733	Ward 7	7	85
734	Ward 8	8	85
735	Ward 9	9	85
736	Ward 10	10	85
737	Ward 11	11	85
738	Ward 1	1	86
739	Ward 2	2	86
740	Ward 3	3	86
741	Ward 4	4	86
742	Ward 5	5	86
743	Ward 6	6	86
744	Ward 7	7	86
745	Ward 8	8	86
746	Ward 9	9	86
747	Ward 10	10	86
748	Ward 11	11	86
749	Ward 1	1	87
750	Ward 2	2	87
751	Ward 3	3	87
752	Ward 4	4	87
753	Ward 5	5	87
754	Ward 6	6	87
755	Ward 7	7	87
756	Ward 8	8	87
757	Ward 9	9	87
758	Ward 1	1	88
759	Ward 2	2	88
760	Ward 3	3	88
761	Ward 4	4	88
762	Ward 5	5	88
763	Ward 6	6	88
764	Ward 7	7	88
765	Ward 8	8	88
766	Ward 9	9	88
767	Ward 1	1	89
768	Ward 2	2	89
769	Ward 3	3	89
770	Ward 4	4	89
771	Ward 5	5	89
772	Ward 6	6	89
773	Ward 7	7	89
774	Ward 8	8	89
775	Ward 9	9	89
776	Ward 1	1	90
777	Ward 2	2	90
778	Ward 3	3	90
779	Ward 4	4	90
780	Ward 5	5	90
781	Ward 6	6	90
782	Ward 1	1	91
783	Ward 2	2	91
784	Ward 3	3	91
785	Ward 4	4	91
786	Ward 5	5	91
787	Ward 1	1	92
788	Ward 2	2	92
789	Ward 3	3	92
790	Ward 4	4	92
791	Ward 5	5	92
792	Ward 6	6	92
793	Ward 1	1	93
794	Ward 2	2	93
795	Ward 3	3	93
796	Ward 4	4	93
797	Ward 5	5	93
798	Ward 1	1	94
799	Ward 2	2	94
800	Ward 3	3	94
801	Ward 4	4	94
802	Ward 5	5	94
803	Ward 1	1	95
804	Ward 2	2	95
805	Ward 3	3	95
806	Ward 4	4	95
807	Ward 5	5	95
808	Ward 6	6	95
809	Ward 7	7	95
810	Ward 8	8	95
811	Ward 9	9	95
812	Ward 10	10	95
813	Ward 11	11	95
814	Ward 1	1	96
815	Ward 2	2	96
816	Ward 3	3	96
817	Ward 4	4	96
818	Ward 5	5	96
819	Ward 6	6	96
820	Ward 7	7	96
821	Ward 1	1	97
822	Ward 2	2	97
823	Ward 3	3	97
824	Ward 4	4	97
825	Ward 5	5	97
826	Ward 1	1	98
827	Ward 2	2	98
828	Ward 3	3	98
829	Ward 4	4	98
830	Ward 5	5	98
831	Ward 6	6	98
832	Ward 7	7	98
833	Ward 8	8	98
834	Ward 9	9	98
835	Ward 1	1	99
836	Ward 2	2	99
837	Ward 3	3	99
838	Ward 4	4	99
839	Ward 5	5	99
840	Ward 1	1	100
841	Ward 2	2	100
842	Ward 3	3	100
843	Ward 4	4	100
844	Ward 5	5	100
845	Ward 1	1	101
846	Ward 2	2	101
847	Ward 3	3	101
848	Ward 4	4	101
849	Ward 5	5	101
850	Ward 1	1	102
851	Ward 2	2	102
852	Ward 3	3	102
853	Ward 4	4	102
854	Ward 5	5	102
855	Ward 1	1	103
856	Ward 2	2	103
857	Ward 3	3	103
858	Ward 4	4	103
859	Ward 5	5	103
860	Ward 6	6	103
861	Ward 7	7	103
862	Ward 8	8	103
863	Ward 9	9	103
864	Ward 10	10	103
865	Ward 11	11	103
866	Ward 1	1	104
867	Ward 2	2	104
868	Ward 3	3	104
869	Ward 4	4	104
870	Ward 5	5	104
871	Ward 6	6	104
872	Ward 7	7	104
873	Ward 8	8	104
874	Ward 9	9	104
875	Ward 10	10	104
876	Ward 1	1	105
877	Ward 2	2	105
878	Ward 3	3	105
879	Ward 4	4	105
880	Ward 5	5	105
881	Ward 6	6	105
882	Ward 7	7	105
883	Ward 8	8	105
884	Ward 9	9	105
885	Ward 10	10	105
886	Ward 11	11	105
887	Ward 12	12	105
888	Ward 1	1	106
889	Ward 2	2	106
890	Ward 3	3	106
891	Ward 4	4	106
892	Ward 5	5	106
893	Ward 6	6	106
894	Ward 7	7	106
895	Ward 8	8	106
896	Ward 9	9	106
897	Ward 1	1	107
898	Ward 2	2	107
899	Ward 3	3	107
900	Ward 4	4	107
901	Ward 5	5	107
902	Ward 6	6	107
903	Ward 7	7	107
904	Ward 8	8	107
905	Ward 9	9	107
906	Ward 10	10	107
907	Ward 11	11	107
908	Ward 12	12	107
909	Ward 13	13	107
910	Ward 14	14	107
911	Ward 15	15	107
912	Ward 16	16	107
913	Ward 17	17	107
914	Ward 18	18	107
915	Ward 19	19	107
916	Ward 20	20	107
917	Ward 1	1	108
918	Ward 2	2	108
919	Ward 3	3	108
920	Ward 4	4	108
921	Ward 5	5	108
922	Ward 6	6	108
923	Ward 7	7	108
924	Ward 8	8	108
925	Ward 9	9	108
926	Ward 10	10	108
927	Ward 11	11	108
928	Ward 12	12	108
929	Ward 13	13	108
930	Ward 14	14	108
931	Ward 15	15	108
932	Ward 16	16	108
933	Ward 17	17	108
934	Ward 18	18	108
935	Ward 19	19	108
936	Ward 20	20	108
937	Ward 1	1	109
938	Ward 2	2	109
939	Ward 3	3	109
940	Ward 4	4	109
941	Ward 5	5	109
942	Ward 6	6	109
943	Ward 7	7	109
944	Ward 8	8	109
945	Ward 1	1	110
946	Ward 2	2	110
947	Ward 3	3	110
948	Ward 4	4	110
949	Ward 5	5	110
950	Ward 6	6	110
951	Ward 7	7	110
952	Ward 1	1	111
953	Ward 2	2	111
954	Ward 3	3	111
955	Ward 4	4	111
956	Ward 5	5	111
957	Ward 6	6	111
958	Ward 7	7	111
959	Ward 8	8	111
960	Ward 1	1	112
961	Ward 2	2	112
962	Ward 3	3	112
963	Ward 4	4	112
964	Ward 5	5	112
965	Ward 6	6	112
966	Ward 7	7	112
967	Ward 1	1	113
968	Ward 2	2	113
969	Ward 3	3	113
970	Ward 4	4	113
971	Ward 5	5	113
972	Ward 6	6	113
973	Ward 1	1	114
974	Ward 2	2	114
975	Ward 3	3	114
976	Ward 4	4	114
977	Ward 5	5	114
978	Ward 6	6	114
979	Ward 1	1	115
980	Ward 2	2	115
981	Ward 3	3	115
982	Ward 4	4	115
983	Ward 5	5	115
984	Ward 6	6	115
985	Ward 7	7	115
986	Ward 8	8	115
987	Ward 9	9	115
988	Ward 10	10	115
989	Ward 11	11	115
990	Ward 1	1	116
991	Ward 2	2	116
992	Ward 3	3	116
993	Ward 4	4	116
994	Ward 5	5	116
995	Ward 6	6	116
996	Ward 7	7	116
997	Ward 8	8	116
998	Ward 1	1	117
999	Ward 2	2	117
1000	Ward 3	3	117
1001	Ward 4	4	117
1002	Ward 5	5	117
1003	Ward 1	1	118
1004	Ward 2	2	118
1005	Ward 3	3	118
1006	Ward 4	4	118
1007	Ward 5	5	118
1008	Ward 6	6	118
1009	Ward 1	1	119
1010	Ward 2	2	119
1011	Ward 3	3	119
1012	Ward 4	4	119
1013	Ward 5	5	119
1014	Ward 6	6	119
1015	Ward 1	1	120
1016	Ward 2	2	120
1017	Ward 3	3	120
1018	Ward 4	4	120
1019	Ward 5	5	120
1020	Ward 6	6	120
1021	Ward 7	7	120
1022	Ward 1	1	121
1023	Ward 2	2	121
1024	Ward 3	3	121
1025	Ward 4	4	121
1026	Ward 5	5	121
1027	Ward 6	6	121
1028	Ward 7	7	121
1029	Ward 1	1	122
1030	Ward 2	2	122
1031	Ward 3	3	122
1032	Ward 4	4	122
1033	Ward 5	5	122
1034	Ward 6	6	122
1035	Ward 1	1	123
1036	Ward 2	2	123
1037	Ward 3	3	123
1038	Ward 4	4	123
1039	Ward 5	5	123
1040	Ward 1	1	124
1041	Ward 2	2	124
1042	Ward 3	3	124
1043	Ward 4	4	124
1044	Ward 5	5	124
1045	Ward 6	6	124
1046	Ward 7	7	124
1047	Ward 8	8	124
1048	Ward 9	9	124
1049	Ward 10	10	124
1050	Ward 1	1	125
1051	Ward 2	2	125
1052	Ward 3	3	125
1053	Ward 4	4	125
1054	Ward 5	5	125
1055	Ward 6	6	125
1056	Ward 7	7	125
1057	Ward 8	8	125
1058	Ward 9	9	125
1059	Ward 1	1	126
1060	Ward 2	2	126
1061	Ward 3	3	126
1062	Ward 4	4	126
1063	Ward 5	5	126
1064	Ward 6	6	126
1065	Ward 7	7	126
1066	Ward 1	1	127
1067	Ward 2	2	127
1068	Ward 3	3	127
1069	Ward 4	4	127
1070	Ward 5	5	127
1071	Ward 1	1	128
1072	Ward 2	2	128
1073	Ward 3	3	128
1074	Ward 4	4	128
1075	Ward 5	5	128
1076	Ward 6	6	128
1077	Ward 1	1	129
1078	Ward 2	2	129
1079	Ward 3	3	129
1080	Ward 4	4	129
1081	Ward 5	5	129
1082	Ward 6	6	129
1083	Ward 1	1	130
1084	Ward 2	2	130
1085	Ward 3	3	130
1086	Ward 4	4	130
1087	Ward 5	5	130
1088	Ward 6	6	130
1089	Ward 7	7	130
1090	Ward 8	8	130
1091	Ward 9	9	130
1092	Ward 10	10	130
1093	Ward 11	11	130
1094	Ward 12	12	130
1095	Ward 13	13	130
1096	Ward 14	14	130
1097	Ward 15	15	130
1098	Ward 16	16	130
1099	Ward 1	1	131
1100	Ward 2	2	131
1101	Ward 3	3	131
1102	Ward 4	4	131
1103	Ward 5	5	131
1104	Ward 6	6	131
1105	Ward 7	7	131
1106	Ward 8	8	131
1107	Ward 9	9	131
1108	Ward 10	10	131
1109	Ward 11	11	131
1110	Ward 12	12	131
1111	Ward 13	13	131
1112	Ward 14	14	131
1113	Ward 1	1	132
1114	Ward 2	2	132
1115	Ward 3	3	132
1116	Ward 4	4	132
1117	Ward 5	5	132
1118	Ward 6	6	132
1119	Ward 7	7	132
1120	Ward 8	8	132
1121	Ward 9	9	132
1122	Ward 10	10	132
1123	Ward 1	1	133
1124	Ward 2	2	133
1125	Ward 3	3	133
1126	Ward 4	4	133
1127	Ward 5	5	133
1128	Ward 6	6	133
1129	Ward 7	7	133
1130	Ward 8	8	133
1131	Ward 9	9	133
1132	Ward 1	1	134
1133	Ward 2	2	134
1134	Ward 3	3	134
1135	Ward 4	4	134
1136	Ward 5	5	134
1137	Ward 6	6	134
1138	Ward 7	7	134
1139	Ward 8	8	134
1140	Ward 1	1	135
1141	Ward 2	2	135
1142	Ward 3	3	135
1143	Ward 4	4	135
1144	Ward 5	5	135
1145	Ward 6	6	135
1146	Ward 7	7	135
1147	Ward 8	8	135
1148	Ward 1	1	136
1149	Ward 2	2	136
1150	Ward 3	3	136
1151	Ward 4	4	136
1152	Ward 5	5	136
1153	Ward 1	1	137
1154	Ward 2	2	137
1155	Ward 3	3	137
1156	Ward 4	4	137
1157	Ward 5	5	137
1158	Ward 1	1	138
1159	Ward 2	2	138
1160	Ward 3	3	138
1161	Ward 4	4	138
1162	Ward 5	5	138
1163	Ward 6	6	138
1164	Ward 7	7	138
1165	Ward 8	8	138
1166	Ward 9	9	138
1167	Ward 10	10	138
1168	Ward 11	11	138
1169	Ward 12	12	138
1170	Ward 13	13	138
1171	Ward 14	14	138
1172	Ward 15	15	138
1173	Ward 16	16	138
1174	Ward 17	17	138
1175	Ward 18	18	138
1176	Ward 19	19	138
1177	Ward 20	20	138
1178	Ward 21	21	138
1179	Ward 22	22	138
1180	Ward 23	23	138
1181	Ward 24	24	138
1182	Ward 25	25	138
1183	Ward 26	26	138
1184	Ward 27	27	138
1185	Ward 28	28	138
1186	Ward 29	29	138
1187	Ward 30	30	138
1188	Ward 31	31	138
1189	Ward 32	32	138
1190	Ward 1	1	139
1191	Ward 2	2	139
1192	Ward 3	3	139
1193	Ward 4	4	139
1194	Ward 5	5	139
1195	Ward 6	6	139
1196	Ward 7	7	139
1197	Ward 8	8	139
1198	Ward 9	9	139
1199	Ward 1	1	140
1200	Ward 2	2	140
1201	Ward 3	3	140
1202	Ward 4	4	140
1203	Ward 5	5	140
1204	Ward 6	6	140
1205	Ward 7	7	140
1206	Ward 8	8	140
1207	Ward 9	9	140
1208	Ward 1	1	141
1209	Ward 2	2	141
1210	Ward 3	3	141
1211	Ward 4	4	141
1212	Ward 5	5	141
1213	Ward 6	6	141
1214	Ward 7	7	141
1215	Ward 8	8	141
1216	Ward 9	9	141
1217	Ward 10	10	141
1218	Ward 1	1	142
1219	Ward 2	2	142
1220	Ward 3	3	142
1221	Ward 4	4	142
1222	Ward 5	5	142
1223	Ward 1	1	143
1224	Ward 2	2	143
1225	Ward 3	3	143
1226	Ward 4	4	143
1227	Ward 5	5	143
1228	Ward 1	1	144
1229	Ward 2	2	144
1230	Ward 3	3	144
1231	Ward 4	4	144
1232	Ward 5	5	144
1233	Ward 1	1	145
1234	Ward 2	2	145
1235	Ward 3	3	145
1236	Ward 4	4	145
1237	Ward 5	5	145
1238	Ward 6	6	145
1239	Ward 1	1	146
1240	Ward 2	2	146
1241	Ward 3	3	146
1242	Ward 4	4	146
1243	Ward 5	5	146
1244	Ward 1	1	147
1245	Ward 2	2	147
1246	Ward 3	3	147
1247	Ward 4	4	147
1248	Ward 5	5	147
1249	Ward 1	1	148
1250	Ward 2	2	148
1251	Ward 3	3	148
1252	Ward 4	4	148
1253	Ward 5	5	148
1254	Ward 1	1	149
1255	Ward 2	2	149
1256	Ward 3	3	149
1257	Ward 4	4	149
1258	Ward 5	5	149
1259	Ward 1	1	150
1260	Ward 2	2	150
1261	Ward 3	3	150
1262	Ward 4	4	150
1263	Ward 5	5	150
1264	Ward 6	6	150
1265	Ward 1	1	151
1266	Ward 2	2	151
1267	Ward 3	3	151
1268	Ward 4	4	151
1269	Ward 5	5	151
1270	Ward 1	1	152
1271	Ward 2	2	152
1272	Ward 3	3	152
1273	Ward 4	4	152
1274	Ward 5	5	152
1275	Ward 6	6	152
1276	Ward 7	7	152
1277	Ward 8	8	152
1278	Ward 9	9	152
1279	Ward 10	10	152
1280	Ward 11	11	152
1281	Ward 12	12	152
1282	Ward 13	13	152
1283	Ward 14	14	152
1284	Ward 15	15	152
1285	Ward 16	16	152
1286	Ward 17	17	152
1287	Ward 18	18	152
1288	Ward 19	19	152
1289	Ward 20	20	152
1290	Ward 21	21	152
1291	Ward 22	22	152
1292	Ward 23	23	152
1293	Ward 24	24	152
1294	Ward 25	25	152
1295	Ward 26	26	152
1296	Ward 27	27	152
1297	Ward 1	1	153
1298	Ward 2	2	153
1299	Ward 3	3	153
1300	Ward 4	4	153
1301	Ward 5	5	153
1302	Ward 6	6	153
1303	Ward 7	7	153
1304	Ward 8	8	153
1305	Ward 9	9	153
1306	Ward 10	10	153
1307	Ward 11	11	153
1308	Ward 12	12	153
1309	Ward 13	13	153
1310	Ward 14	14	153
1311	Ward 15	15	153
1312	Ward 16	16	153
1313	Ward 17	17	153
1314	Ward 18	18	153
1315	Ward 19	19	153
1316	Ward 20	20	153
1317	Ward 21	21	153
1318	Ward 22	22	153
1319	Ward 23	23	153
1320	Ward 24	24	153
1321	Ward 1	1	154
1322	Ward 2	2	154
1323	Ward 3	3	154
1324	Ward 4	4	154
1325	Ward 5	5	154
1326	Ward 6	6	154
1327	Ward 7	7	154
1328	Ward 8	8	154
1329	Ward 9	9	154
1330	Ward 10	10	154
1331	Ward 11	11	154
1332	Ward 1	1	155
1333	Ward 2	2	155
1334	Ward 3	3	155
1335	Ward 4	4	155
1336	Ward 5	5	155
1337	Ward 6	6	155
1338	Ward 7	7	155
1339	Ward 8	8	155
1340	Ward 9	9	155
1341	Ward 10	10	155
1342	Ward 11	11	155
1343	Ward 12	12	155
1344	Ward 13	13	155
1345	Ward 1	1	156
1346	Ward 2	2	156
1347	Ward 3	3	156
1348	Ward 4	4	156
1349	Ward 5	5	156
1350	Ward 6	6	156
1351	Ward 7	7	156
1352	Ward 8	8	156
1353	Ward 9	9	156
1354	Ward 10	10	156
1355	Ward 11	11	156
1356	Ward 1	1	157
1357	Ward 2	2	157
1358	Ward 3	3	157
1359	Ward 4	4	157
1360	Ward 5	5	157
1361	Ward 6	6	157
1362	Ward 7	7	157
1363	Ward 8	8	157
1364	Ward 9	9	157
1365	Ward 10	10	157
1366	Ward 11	11	157
1367	Ward 1	1	158
1368	Ward 2	2	158
1369	Ward 3	3	158
1370	Ward 4	4	158
1371	Ward 5	5	158
1372	Ward 6	6	158
1373	Ward 7	7	158
1374	Ward 8	8	158
1375	Ward 9	9	158
1376	Ward 1	1	159
1377	Ward 2	2	159
1378	Ward 3	3	159
1379	Ward 4	4	159
1380	Ward 5	5	159
1381	Ward 6	6	159
1382	Ward 7	7	159
1383	Ward 1	1	160
1384	Ward 2	2	160
1385	Ward 3	3	160
1386	Ward 4	4	160
1387	Ward 5	5	160
1388	Ward 1	1	161
1389	Ward 2	2	161
1390	Ward 3	3	161
1391	Ward 4	4	161
1392	Ward 5	5	161
1393	Ward 6	6	161
1394	Ward 7	7	161
1395	Ward 1	1	162
1396	Ward 2	2	162
1397	Ward 3	3	162
1398	Ward 4	4	162
1399	Ward 5	5	162
1400	Ward 6	6	162
1401	Ward 7	7	162
1402	Ward 8	8	162
1403	Ward 1	1	163
1404	Ward 2	2	163
1405	Ward 3	3	163
1406	Ward 4	4	163
1407	Ward 5	5	163
1408	Ward 6	6	163
1409	Ward 7	7	163
1410	Ward 8	8	163
1411	Ward 1	1	164
1412	Ward 2	2	164
1413	Ward 3	3	164
1414	Ward 4	4	164
1415	Ward 5	5	164
1416	Ward 6	6	164
1417	Ward 7	7	164
1418	Ward 1	1	165
1419	Ward 2	2	165
1420	Ward 3	3	165
1421	Ward 4	4	165
1422	Ward 5	5	165
1423	Ward 1	1	166
1424	Ward 2	2	166
1425	Ward 3	3	166
1426	Ward 4	4	166
1427	Ward 5	5	166
1428	Ward 6	6	166
1429	Ward 1	1	167
1430	Ward 2	2	167
1431	Ward 3	3	167
1432	Ward 4	4	167
1433	Ward 5	5	167
1434	Ward 6	6	167
1435	Ward 7	7	167
1436	Ward 8	8	167
1437	Ward 1	1	168
1438	Ward 2	2	168
1439	Ward 3	3	168
1440	Ward 4	4	168
1441	Ward 5	5	168
1442	Ward 6	6	168
1443	Ward 7	7	168
1444	Ward 8	8	168
1445	Ward 9	9	168
1446	Ward 1	1	169
1447	Ward 2	2	169
1448	Ward 3	3	169
1449	Ward 4	4	169
1450	Ward 5	5	169
1451	Ward 6	6	169
1452	Ward 7	7	169
1453	Ward 8	8	169
1454	Ward 9	9	169
1455	Ward 1	1	170
1456	Ward 2	2	170
1457	Ward 3	3	170
1458	Ward 4	4	170
1459	Ward 5	5	170
1460	Ward 6	6	170
1461	Ward 7	7	170
1462	Ward 8	8	170
1463	Ward 9	9	170
1464	Ward 10	10	170
1465	Ward 1	1	171
1466	Ward 2	2	171
1467	Ward 3	3	171
1468	Ward 4	4	171
1469	Ward 5	5	171
1470	Ward 6	6	171
1471	Ward 7	7	171
1472	Ward 8	8	171
1473	Ward 9	9	171
1474	Ward 1	1	172
1475	Ward 2	2	172
1476	Ward 3	3	172
1477	Ward 4	4	172
1478	Ward 5	5	172
1479	Ward 6	6	172
1480	Ward 7	7	172
1481	Ward 8	8	172
1482	Ward 9	9	172
1483	Ward 1	1	173
1484	Ward 2	2	173
1485	Ward 3	3	173
1486	Ward 4	4	173
1487	Ward 5	5	173
1488	Ward 6	6	173
1489	Ward 7	7	173
1490	Ward 8	8	173
1491	Ward 9	9	173
1492	Ward 1	1	174
1493	Ward 2	2	174
1494	Ward 3	3	174
1495	Ward 4	4	174
1496	Ward 5	5	174
1497	Ward 6	6	174
1498	Ward 7	7	174
1499	Ward 8	8	174
1500	Ward 9	9	174
1501	Ward 1	1	175
1502	Ward 2	2	175
1503	Ward 3	3	175
1504	Ward 4	4	175
1505	Ward 5	5	175
1506	Ward 6	6	175
1507	Ward 7	7	175
1508	Ward 8	8	175
1509	Ward 9	9	175
1510	Ward 1	1	176
1511	Ward 2	2	176
1512	Ward 3	3	176
1513	Ward 4	4	176
1514	Ward 5	5	176
1515	Ward 6	6	176
1516	Ward 7	7	176
1517	Ward 8	8	176
1518	Ward 9	9	176
1519	Ward 1	1	177
1520	Ward 2	2	177
1521	Ward 3	3	177
1522	Ward 4	4	177
1523	Ward 5	5	177
1524	Ward 6	6	177
1525	Ward 7	7	177
1526	Ward 8	8	177
1527	Ward 9	9	177
1528	Ward 1	1	178
1529	Ward 2	2	178
1530	Ward 3	3	178
1531	Ward 4	4	178
1532	Ward 5	5	178
1533	Ward 6	6	178
1534	Ward 7	7	178
1535	Ward 8	8	178
1536	Ward 9	9	178
1537	Ward 1	1	179
1538	Ward 2	2	179
1539	Ward 3	3	179
1540	Ward 4	4	179
1541	Ward 5	5	179
1542	Ward 6	6	179
1543	Ward 7	7	179
1544	Ward 8	8	179
1545	Ward 9	9	179
1546	Ward 1	1	180
1547	Ward 2	2	180
1548	Ward 3	3	180
1549	Ward 4	4	180
1550	Ward 5	5	180
1551	Ward 6	6	180
1552	Ward 7	7	180
1553	Ward 8	8	180
1554	Ward 9	9	180
1555	Ward 1	1	181
1556	Ward 2	2	181
1557	Ward 3	3	181
1558	Ward 4	4	181
1559	Ward 5	5	181
1560	Ward 6	6	181
1561	Ward 7	7	181
1562	Ward 8	8	181
1563	Ward 9	9	181
1564	Ward 10	10	181
1565	Ward 11	11	181
1566	Ward 1	1	182
1567	Ward 2	2	182
1568	Ward 3	3	182
1569	Ward 4	4	182
1570	Ward 5	5	182
1571	Ward 6	6	182
1572	Ward 7	7	182
1573	Ward 8	8	182
1574	Ward 9	9	182
1575	Ward 1	1	183
1576	Ward 2	2	183
1577	Ward 3	3	183
1578	Ward 4	4	183
1579	Ward 5	5	183
1580	Ward 6	6	183
1581	Ward 7	7	183
1582	Ward 8	8	183
1583	Ward 9	9	183
1584	Ward 1	1	184
1585	Ward 2	2	184
1586	Ward 3	3	184
1587	Ward 4	4	184
1588	Ward 5	5	184
1589	Ward 1	1	185
1590	Ward 2	2	185
1591	Ward 3	3	185
1592	Ward 4	4	185
1593	Ward 5	5	185
1594	Ward 1	1	186
1595	Ward 2	2	186
1596	Ward 3	3	186
1597	Ward 4	4	186
1598	Ward 5	5	186
1599	Ward 6	6	186
1600	Ward 7	7	186
1601	Ward 8	8	186
1602	Ward 9	9	186
1603	Ward 10	10	186
1604	Ward 11	11	186
1605	Ward 12	12	186
1606	Ward 1	1	187
1607	Ward 2	2	187
1608	Ward 3	3	187
1609	Ward 4	4	187
1610	Ward 5	5	187
1611	Ward 6	6	187
1612	Ward 7	7	187
1613	Ward 8	8	187
1614	Ward 9	9	187
1615	Ward 10	10	187
1616	Ward 11	11	187
1617	Ward 1	1	188
1618	Ward 2	2	188
1619	Ward 3	3	188
1620	Ward 4	4	188
1621	Ward 5	5	188
1622	Ward 6	6	188
1623	Ward 7	7	188
1624	Ward 8	8	188
1625	Ward 9	9	188
1626	Ward 10	10	188
1627	Ward 11	11	188
1628	Ward 12	12	188
1629	Ward 13	13	188
1630	Ward 14	14	188
1631	Ward 15	15	188
1632	Ward 16	16	188
1633	Ward 17	17	188
1634	Ward 18	18	188
1635	Ward 1	1	189
1636	Ward 2	2	189
1637	Ward 3	3	189
1638	Ward 4	4	189
1639	Ward 5	5	189
1640	Ward 6	6	189
1641	Ward 7	7	189
1642	Ward 8	8	189
1643	Ward 9	9	189
1644	Ward 10	10	189
1645	Ward 11	11	189
1646	Ward 12	12	189
1647	Ward 1	1	190
1648	Ward 2	2	190
1649	Ward 3	3	190
1650	Ward 4	4	190
1651	Ward 5	5	190
1652	Ward 6	6	190
1653	Ward 7	7	190
1654	Ward 8	8	190
1655	Ward 9	9	190
1656	Ward 10	10	190
1657	Ward 11	11	190
1658	Ward 1	1	191
1659	Ward 2	2	191
1660	Ward 3	3	191
1661	Ward 4	4	191
1662	Ward 5	5	191
1663	Ward 6	6	191
1664	Ward 7	7	191
1665	Ward 8	8	191
1666	Ward 9	9	191
1667	Ward 1	1	192
1668	Ward 2	2	192
1669	Ward 3	3	192
1670	Ward 4	4	192
1671	Ward 5	5	192
1672	Ward 6	6	192
1673	Ward 7	7	192
1674	Ward 8	8	192
1675	Ward 9	9	192
1676	Ward 1	1	193
1677	Ward 2	2	193
1678	Ward 3	3	193
1679	Ward 4	4	193
1680	Ward 5	5	193
1681	Ward 6	6	193
1682	Ward 7	7	193
1683	Ward 8	8	193
1684	Ward 9	9	193
1685	Ward 10	10	193
1686	Ward 11	11	193
1687	Ward 12	12	193
1688	Ward 13	13	193
1689	Ward 14	14	193
1690	Ward 15	15	193
1691	Ward 1	1	194
1692	Ward 2	2	194
1693	Ward 3	3	194
1694	Ward 4	4	194
1695	Ward 5	5	194
1696	Ward 6	6	194
1697	Ward 7	7	194
1698	Ward 8	8	194
1699	Ward 9	9	194
1700	Ward 10	10	194
1701	Ward 1	1	195
1702	Ward 2	2	195
1703	Ward 3	3	195
1704	Ward 4	4	195
1705	Ward 5	5	195
1706	Ward 6	6	195
1707	Ward 7	7	195
1708	Ward 8	8	195
1709	Ward 9	9	195
1710	Ward 10	10	195
1711	Ward 11	11	195
1712	Ward 12	12	195
1713	Ward 13	13	195
1714	Ward 14	14	195
1715	Ward 15	15	195
1716	Ward 16	16	195
1717	Ward 17	17	195
1718	Ward 1	1	196
1719	Ward 2	2	196
1720	Ward 3	3	196
1721	Ward 4	4	196
1722	Ward 5	5	196
1723	Ward 6	6	196
1724	Ward 7	7	196
1725	Ward 8	8	196
1726	Ward 9	9	196
1727	Ward 10	10	196
1728	Ward 11	11	196
1729	Ward 12	12	196
1730	Ward 1	1	197
1731	Ward 2	2	197
1732	Ward 3	3	197
1733	Ward 4	4	197
1734	Ward 5	5	197
1735	Ward 6	6	197
1736	Ward 1	1	198
1737	Ward 2	2	198
1738	Ward 3	3	198
1739	Ward 4	4	198
1740	Ward 5	5	198
1741	Ward 6	6	198
1742	Ward 7	7	198
1743	Ward 8	8	198
1744	Ward 1	1	199
1745	Ward 2	2	199
1746	Ward 3	3	199
1747	Ward 4	4	199
1748	Ward 5	5	199
1749	Ward 6	6	199
1750	Ward 7	7	199
1751	Ward 1	1	200
1752	Ward 2	2	200
1753	Ward 3	3	200
1754	Ward 4	4	200
1755	Ward 5	5	200
1756	Ward 6	6	200
1757	Ward 7	7	200
1758	Ward 8	8	200
1759	Ward 9	9	200
1760	Ward 1	1	201
1761	Ward 2	2	201
1762	Ward 3	3	201
1763	Ward 4	4	201
1764	Ward 5	5	201
1765	Ward 6	6	201
1766	Ward 7	7	201
1767	Ward 1	1	202
1768	Ward 2	2	202
1769	Ward 3	3	202
1770	Ward 4	4	202
1771	Ward 5	5	202
1772	Ward 6	6	202
1773	Ward 7	7	202
1774	Ward 1	1	203
1775	Ward 2	2	203
1776	Ward 3	3	203
1777	Ward 4	4	203
1778	Ward 5	5	203
1779	Ward 6	6	203
1780	Ward 7	7	203
1781	Ward 1	1	204
1782	Ward 2	2	204
1783	Ward 3	3	204
1784	Ward 4	4	204
1785	Ward 5	5	204
1786	Ward 6	6	204
1787	Ward 1	1	205
1788	Ward 2	2	205
1789	Ward 3	3	205
1790	Ward 4	4	205
1791	Ward 5	5	205
1792	Ward 6	6	205
1793	Ward 7	7	205
1794	Ward 1	1	206
1795	Ward 2	2	206
1796	Ward 3	3	206
1797	Ward 4	4	206
1798	Ward 5	5	206
1799	Ward 6	6	206
1800	Ward 7	7	206
1801	Ward 8	8	206
1802	Ward 9	9	206
1803	Ward 10	10	206
1804	Ward 11	11	206
1805	Ward 12	12	206
1806	Ward 13	13	206
1807	Ward 14	14	206
1808	Ward 15	15	206
1809	Ward 16	16	206
1810	Ward 17	17	206
1811	Ward 18	18	206
1812	Ward 19	19	206
1813	Ward 20	20	206
1814	Ward 21	21	206
1815	Ward 22	22	206
1816	Ward 23	23	206
1817	Ward 24	24	206
1818	Ward 1	1	207
1819	Ward 2	2	207
1820	Ward 3	3	207
1821	Ward 4	4	207
1822	Ward 5	5	207
1823	Ward 6	6	207
1824	Ward 7	7	207
1825	Ward 8	8	207
1826	Ward 9	9	207
1827	Ward 10	10	207
1828	Ward 11	11	207
1829	Ward 12	12	207
1830	Ward 13	13	207
1831	Ward 14	14	207
1832	Ward 1	1	208
1833	Ward 2	2	208
1834	Ward 3	3	208
1835	Ward 4	4	208
1836	Ward 5	5	208
1837	Ward 6	6	208
1838	Ward 7	7	208
1839	Ward 8	8	208
1840	Ward 9	9	208
1841	Ward 10	10	208
1842	Ward 11	11	208
1843	Ward 12	12	208
1844	Ward 13	13	208
1845	Ward 14	14	208
1846	Ward 15	15	208
1847	Ward 16	16	208
1848	Ward 17	17	208
1849	Ward 18	18	208
1850	Ward 19	19	208
1851	Ward 20	20	208
1852	Ward 21	21	208
1853	Ward 22	22	208
1854	Ward 1	1	209
1855	Ward 2	2	209
1856	Ward 3	3	209
1857	Ward 4	4	209
1858	Ward 5	5	209
1859	Ward 6	6	209
1860	Ward 7	7	209
1861	Ward 8	8	209
1862	Ward 9	9	209
1863	Ward 10	10	209
1864	Ward 11	11	209
1865	Ward 12	12	209
1866	Ward 13	13	209
1867	Ward 1	1	210
1868	Ward 2	2	210
1869	Ward 3	3	210
1870	Ward 4	4	210
1871	Ward 5	5	210
1872	Ward 6	6	210
1873	Ward 7	7	210
1874	Ward 8	8	210
1875	Ward 9	9	210
1876	Ward 10	10	210
1877	Ward 11	11	210
1878	Ward 12	12	210
1879	Ward 1	1	211
1880	Ward 2	2	211
1881	Ward 3	3	211
1882	Ward 4	4	211
1883	Ward 5	5	211
1884	Ward 6	6	211
1885	Ward 7	7	211
1886	Ward 8	8	211
1887	Ward 9	9	211
1888	Ward 10	10	211
1889	Ward 11	11	211
1890	Ward 12	12	211
1891	Ward 1	1	212
1892	Ward 2	2	212
1893	Ward 3	3	212
1894	Ward 4	4	212
1895	Ward 5	5	212
1896	Ward 6	6	212
1897	Ward 7	7	212
1898	Ward 8	8	212
1899	Ward 9	9	212
1900	Ward 10	10	212
1901	Ward 11	11	212
1902	Ward 1	1	213
1903	Ward 2	2	213
1904	Ward 3	3	213
1905	Ward 4	4	213
1906	Ward 5	5	213
1907	Ward 6	6	213
1908	Ward 7	7	213
1909	Ward 8	8	213
1910	Ward 9	9	213
1911	Ward 10	10	213
1912	Ward 1	1	214
1913	Ward 2	2	214
1914	Ward 3	3	214
1915	Ward 4	4	214
1916	Ward 5	5	214
1917	Ward 1	1	215
1918	Ward 2	2	215
1919	Ward 3	3	215
1920	Ward 4	4	215
1921	Ward 5	5	215
1922	Ward 1	1	216
1923	Ward 2	2	216
1924	Ward 3	3	216
1925	Ward 4	4	216
1926	Ward 5	5	216
1927	Ward 1	1	217
1928	Ward 2	2	217
1929	Ward 3	3	217
1930	Ward 4	4	217
1931	Ward 5	5	217
1932	Ward 1	1	218
1933	Ward 2	2	218
1934	Ward 3	3	218
1935	Ward 4	4	218
1936	Ward 5	5	218
1937	Ward 6	6	218
1938	Ward 1	1	219
1939	Ward 2	2	219
1940	Ward 3	3	219
1941	Ward 4	4	219
1942	Ward 5	5	219
1943	Ward 1	1	220
1944	Ward 2	2	220
1945	Ward 3	3	220
1946	Ward 4	4	220
1947	Ward 5	5	220
1948	Ward 1	1	221
1949	Ward 2	2	221
1950	Ward 3	3	221
1951	Ward 4	4	221
1952	Ward 5	5	221
1953	Ward 1	1	222
1954	Ward 2	2	222
1955	Ward 3	3	222
1956	Ward 4	4	222
1957	Ward 5	5	222
1958	Ward 1	1	223
1959	Ward 2	2	223
1960	Ward 3	3	223
1961	Ward 4	4	223
1962	Ward 5	5	223
1963	Ward 6	6	223
1964	Ward 7	7	223
1965	Ward 8	8	223
1966	Ward 9	9	223
1967	Ward 10	10	223
1968	Ward 11	11	223
1969	Ward 12	12	223
1970	Ward 13	13	223
1971	Ward 14	14	223
1972	Ward 15	15	223
1973	Ward 16	16	223
1974	Ward 17	17	223
1975	Ward 18	18	223
1976	Ward 19	19	223
1977	Ward 20	20	223
1978	Ward 21	21	223
1979	Ward 22	22	223
1980	Ward 23	23	223
1981	Ward 24	24	223
1982	Ward 25	25	223
1983	Ward 1	1	224
1984	Ward 2	2	224
1985	Ward 3	3	224
1986	Ward 4	4	224
1987	Ward 5	5	224
1988	Ward 6	6	224
1989	Ward 7	7	224
1990	Ward 8	8	224
1991	Ward 9	9	224
1992	Ward 10	10	224
1993	Ward 1	1	225
1994	Ward 2	2	225
1995	Ward 3	3	225
1996	Ward 4	4	225
1997	Ward 5	5	225
1998	Ward 6	6	225
1999	Ward 7	7	225
2000	Ward 8	8	225
2001	Ward 9	9	225
2002	Ward 10	10	225
2003	Ward 11	11	225
2004	Ward 1	1	226
2005	Ward 2	2	226
2006	Ward 3	3	226
2007	Ward 4	4	226
2008	Ward 5	5	226
2009	Ward 6	6	226
2010	Ward 7	7	226
2011	Ward 8	8	226
2012	Ward 9	9	226
2013	Ward 1	1	227
2014	Ward 2	2	227
2015	Ward 3	3	227
2016	Ward 4	4	227
2017	Ward 5	5	227
2018	Ward 6	6	227
2019	Ward 7	7	227
2020	Ward 8	8	227
2021	Ward 9	9	227
2022	Ward 1	1	228
2023	Ward 2	2	228
2024	Ward 3	3	228
2025	Ward 4	4	228
2026	Ward 5	5	228
2027	Ward 6	6	228
2028	Ward 7	7	228
2029	Ward 8	8	228
2030	Ward 9	9	228
2031	Ward 1	1	229
2032	Ward 2	2	229
2033	Ward 3	3	229
2034	Ward 4	4	229
2035	Ward 5	5	229
2036	Ward 6	6	229
2037	Ward 7	7	229
2038	Ward 8	8	229
2039	Ward 9	9	229
2040	Ward 10	10	229
2041	Ward 11	11	229
2042	Ward 1	1	230
2043	Ward 2	2	230
2044	Ward 3	3	230
2045	Ward 4	4	230
2046	Ward 5	5	230
2047	Ward 6	6	230
2048	Ward 7	7	230
2049	Ward 8	8	230
2050	Ward 9	9	230
2051	Ward 1	1	231
2052	Ward 2	2	231
2053	Ward 3	3	231
2054	Ward 4	4	231
2055	Ward 5	5	231
2056	Ward 6	6	231
2057	Ward 7	7	231
2058	Ward 8	8	231
2059	Ward 9	9	231
2060	Ward 10	10	231
2061	Ward 11	11	231
2062	Ward 12	12	231
2063	Ward 13	13	231
2064	Ward 1	1	232
2065	Ward 2	2	232
2066	Ward 3	3	232
2067	Ward 4	4	232
2068	Ward 5	5	232
2069	Ward 6	6	232
2070	Ward 7	7	232
2071	Ward 8	8	232
2072	Ward 9	9	232
2073	Ward 1	1	233
2074	Ward 2	2	233
2075	Ward 3	3	233
2076	Ward 4	4	233
2077	Ward 5	5	233
2078	Ward 6	6	233
2079	Ward 7	7	233
2080	Ward 8	8	233
2081	Ward 9	9	233
2082	Ward 10	10	233
2083	Ward 1	1	234
2084	Ward 2	2	234
2085	Ward 3	3	234
2086	Ward 4	4	234
2087	Ward 5	5	234
2088	Ward 6	6	234
2089	Ward 7	7	234
2090	Ward 8	8	234
2091	Ward 9	9	234
2092	Ward 1	1	235
2093	Ward 2	2	235
2094	Ward 3	3	235
2095	Ward 4	4	235
2096	Ward 5	5	235
2097	Ward 6	6	235
2098	Ward 1	1	236
2099	Ward 2	2	236
2100	Ward 3	3	236
2101	Ward 4	4	236
2102	Ward 5	5	236
2103	Ward 1	1	237
2104	Ward 2	2	237
2105	Ward 3	3	237
2106	Ward 4	4	237
2107	Ward 5	5	237
2108	Ward 6	6	237
2109	Ward 1	1	238
2110	Ward 2	2	238
2111	Ward 3	3	238
2112	Ward 4	4	238
2113	Ward 5	5	238
2114	Ward 6	6	238
2115	Ward 7	7	238
2116	Ward 1	1	239
2117	Ward 2	2	239
2118	Ward 3	3	239
2119	Ward 4	4	239
2120	Ward 5	5	239
2121	Ward 6	6	239
2122	Ward 1	1	240
2123	Ward 2	2	240
2124	Ward 3	3	240
2125	Ward 4	4	240
2126	Ward 5	5	240
2127	Ward 1	1	241
2128	Ward 2	2	241
2129	Ward 3	3	241
2130	Ward 4	4	241
2131	Ward 5	5	241
2132	Ward 6	6	241
2133	Ward 7	7	241
2134	Ward 8	8	241
2135	Ward 9	9	241
2136	Ward 10	10	241
2137	Ward 1	1	242
2138	Ward 2	2	242
2139	Ward 3	3	242
2140	Ward 4	4	242
2141	Ward 5	5	242
2142	Ward 6	6	242
2143	Ward 7	7	242
2144	Ward 8	8	242
2145	Ward 9	9	242
2146	Ward 10	10	242
2147	Ward 1	1	243
2148	Ward 2	2	243
2149	Ward 3	3	243
2150	Ward 4	4	243
2151	Ward 5	5	243
2152	Ward 6	6	243
2153	Ward 7	7	243
2154	Ward 8	8	243
2155	Ward 9	9	243
2156	Ward 10	10	243
2157	Ward 11	11	243
2158	Ward 12	12	243
2159	Ward 13	13	243
2160	Ward 14	14	243
2161	Ward 1	1	244
2162	Ward 2	2	244
2163	Ward 3	3	244
2164	Ward 4	4	244
2165	Ward 5	5	244
2166	Ward 6	6	244
2167	Ward 7	7	244
2168	Ward 8	8	244
2169	Ward 9	9	244
2170	Ward 10	10	244
2171	Ward 11	11	244
2172	Ward 12	12	244
2173	Ward 1	1	245
2174	Ward 2	2	245
2175	Ward 3	3	245
2176	Ward 4	4	245
2177	Ward 5	5	245
2178	Ward 6	6	245
2179	Ward 7	7	245
2180	Ward 8	8	245
2181	Ward 9	9	245
2182	Ward 10	10	245
2183	Ward 11	11	245
2184	Ward 1	1	246
2185	Ward 2	2	246
2186	Ward 3	3	246
2187	Ward 4	4	246
2188	Ward 5	5	246
2189	Ward 6	6	246
2190	Ward 7	7	246
2191	Ward 8	8	246
2192	Ward 9	9	246
2193	Ward 10	10	246
2194	Ward 11	11	246
2195	Ward 12	12	246
2196	Ward 1	1	247
2197	Ward 2	2	247
2198	Ward 3	3	247
2199	Ward 4	4	247
2200	Ward 5	5	247
2201	Ward 6	6	247
2202	Ward 7	7	247
2203	Ward 8	8	247
2204	Ward 9	9	247
2205	Ward 10	10	247
2206	Ward 11	11	247
2207	Ward 1	1	248
2208	Ward 2	2	248
2209	Ward 3	3	248
2210	Ward 4	4	248
2211	Ward 5	5	248
2212	Ward 6	6	248
2213	Ward 7	7	248
2214	Ward 8	8	248
2215	Ward 9	9	248
2216	Ward 10	10	248
2217	Ward 11	11	248
2218	Ward 1	1	249
2219	Ward 2	2	249
2220	Ward 3	3	249
2221	Ward 4	4	249
2222	Ward 5	5	249
2223	Ward 6	6	249
2224	Ward 7	7	249
2225	Ward 8	8	249
2226	Ward 9	9	249
2227	Ward 10	10	249
2228	Ward 11	11	249
2229	Ward 12	12	249
2230	Ward 13	13	249
2231	Ward 14	14	249
2232	Ward 15	15	249
2233	Ward 16	16	249
2234	Ward 1	1	250
2235	Ward 2	2	250
2236	Ward 3	3	250
2237	Ward 4	4	250
2238	Ward 5	5	250
2239	Ward 6	6	250
2240	Ward 1	1	251
2241	Ward 2	2	251
2242	Ward 3	3	251
2243	Ward 4	4	251
2244	Ward 5	5	251
2245	Ward 6	6	251
2246	Ward 1	1	252
2247	Ward 2	2	252
2248	Ward 3	3	252
2249	Ward 4	4	252
2250	Ward 5	5	252
2251	Ward 6	6	252
2252	Ward 1	1	253
2253	Ward 2	2	253
2254	Ward 3	3	253
2255	Ward 4	4	253
2256	Ward 5	5	253
2257	Ward 6	6	253
2258	Ward 7	7	253
2259	Ward 1	1	254
2260	Ward 2	2	254
2261	Ward 3	3	254
2262	Ward 4	4	254
2263	Ward 5	5	254
2264	Ward 6	6	254
2265	Ward 7	7	254
2266	Ward 1	1	255
2267	Ward 2	2	255
2268	Ward 3	3	255
2269	Ward 4	4	255
2270	Ward 5	5	255
2271	Ward 6	6	255
2272	Ward 1	1	256
2273	Ward 2	2	256
2274	Ward 3	3	256
2275	Ward 4	4	256
2276	Ward 5	5	256
2277	Ward 6	6	256
2278	Ward 1	1	257
2279	Ward 2	2	257
2280	Ward 3	3	257
2281	Ward 4	4	257
2282	Ward 5	5	257
2283	Ward 6	6	257
2284	Ward 7	7	257
2285	Ward 8	8	257
2286	Ward 1	1	258
2287	Ward 2	2	258
2288	Ward 3	3	258
2289	Ward 4	4	258
2290	Ward 5	5	258
2291	Ward 1	1	259
2292	Ward 2	2	259
2293	Ward 3	3	259
2294	Ward 4	4	259
2295	Ward 5	5	259
2296	Ward 6	6	259
2297	Ward 7	7	259
2298	Ward 8	8	259
2299	Ward 9	9	259
2300	Ward 1	1	260
2301	Ward 2	2	260
2302	Ward 3	3	260
2303	Ward 4	4	260
2304	Ward 5	5	260
2305	Ward 6	6	260
2306	Ward 7	7	260
2307	Ward 8	8	260
2308	Ward 9	9	260
2309	Ward 10	10	260
2310	Ward 11	11	260
2311	Ward 1	1	261
2312	Ward 2	2	261
2313	Ward 3	3	261
2314	Ward 4	4	261
2315	Ward 5	5	261
2316	Ward 6	6	261
2317	Ward 7	7	261
2318	Ward 8	8	261
2319	Ward 9	9	261
2320	Ward 10	10	261
2321	Ward 11	11	261
2322	Ward 12	12	261
2323	Ward 13	13	261
2324	Ward 14	14	261
2325	Ward 1	1	262
2326	Ward 2	2	262
2327	Ward 3	3	262
2328	Ward 4	4	262
2329	Ward 5	5	262
2330	Ward 6	6	262
2331	Ward 7	7	262
2332	Ward 8	8	262
2333	Ward 9	9	262
2334	Ward 1	1	263
2335	Ward 2	2	263
2336	Ward 3	3	263
2337	Ward 4	4	263
2338	Ward 5	5	263
2339	Ward 6	6	263
2340	Ward 7	7	263
2341	Ward 8	8	263
2342	Ward 9	9	263
2343	Ward 10	10	263
2344	Ward 11	11	263
2345	Ward 12	12	263
2346	Ward 1	1	264
2347	Ward 2	2	264
2348	Ward 3	3	264
2349	Ward 4	4	264
2350	Ward 5	5	264
2351	Ward 6	6	264
2352	Ward 7	7	264
2353	Ward 8	8	264
2354	Ward 9	9	264
2355	Ward 10	10	264
2356	Ward 11	11	264
2357	Ward 12	12	264
2358	Ward 1	1	265
2359	Ward 2	2	265
2360	Ward 3	3	265
2361	Ward 4	4	265
2362	Ward 5	5	265
2363	Ward 6	6	265
2364	Ward 7	7	265
2365	Ward 8	8	265
2366	Ward 9	9	265
2367	Ward 1	1	266
2368	Ward 2	2	266
2369	Ward 3	3	266
2370	Ward 4	4	266
2371	Ward 5	5	266
2372	Ward 6	6	266
2373	Ward 7	7	266
2374	Ward 8	8	266
2375	Ward 9	9	266
2376	Ward 10	10	266
2377	Ward 1	1	267
2378	Ward 2	2	267
2379	Ward 3	3	267
2380	Ward 4	4	267
2381	Ward 5	5	267
2382	Ward 6	6	267
2383	Ward 7	7	267
2384	Ward 8	8	267
2385	Ward 9	9	267
2386	Ward 1	1	268
2387	Ward 2	2	268
2388	Ward 3	3	268
2389	Ward 4	4	268
2390	Ward 5	5	268
2391	Ward 6	6	268
2392	Ward 7	7	268
2393	Ward 8	8	268
2394	Ward 9	9	268
2395	Ward 1	1	269
2396	Ward 2	2	269
2397	Ward 3	3	269
2398	Ward 4	4	269
2399	Ward 5	5	269
2400	Ward 6	6	269
2401	Ward 1	1	270
2402	Ward 2	2	270
2403	Ward 3	3	270
2404	Ward 4	4	270
2405	Ward 5	5	270
2406	Ward 6	6	270
2407	Ward 1	1	271
2408	Ward 2	2	271
2409	Ward 3	3	271
2410	Ward 4	4	271
2411	Ward 5	5	271
2412	Ward 6	6	271
2413	Ward 7	7	271
2414	Ward 1	1	272
2415	Ward 2	2	272
2416	Ward 3	3	272
2417	Ward 4	4	272
2418	Ward 5	5	272
2419	Ward 6	6	272
2420	Ward 7	7	272
2421	Ward 1	1	273
2422	Ward 2	2	273
2423	Ward 3	3	273
2424	Ward 4	4	273
2425	Ward 5	5	273
2426	Ward 6	6	273
2427	Ward 7	7	273
2428	Ward 8	8	273
2429	Ward 1	1	274
2430	Ward 2	2	274
2431	Ward 3	3	274
2432	Ward 4	4	274
2433	Ward 5	5	274
2434	Ward 6	6	274
2435	Ward 7	7	274
2436	Ward 8	8	274
2437	Ward 9	9	274
2438	Ward 10	10	274
2439	Ward 1	1	275
2440	Ward 2	2	275
2441	Ward 3	3	275
2442	Ward 4	4	275
2443	Ward 5	5	275
2444	Ward 6	6	275
2445	Ward 7	7	275
2446	Ward 8	8	275
2447	Ward 9	9	275
2448	Ward 1	1	276
2449	Ward 2	2	276
2450	Ward 3	3	276
2451	Ward 4	4	276
2452	Ward 5	5	276
2453	Ward 6	6	276
2454	Ward 7	7	276
2455	Ward 8	8	276
2456	Ward 9	9	276
2457	Ward 10	10	276
2458	Ward 1	1	277
2459	Ward 2	2	277
2460	Ward 3	3	277
2461	Ward 4	4	277
2462	Ward 5	5	277
2463	Ward 6	6	277
2464	Ward 7	7	277
2465	Ward 8	8	277
2466	Ward 9	9	277
2467	Ward 1	1	278
2468	Ward 2	2	278
2469	Ward 3	3	278
2470	Ward 4	4	278
2471	Ward 5	5	278
2472	Ward 6	6	278
2473	Ward 7	7	278
2474	Ward 8	8	278
2475	Ward 9	9	278
2476	Ward 10	10	278
2477	Ward 11	11	278
2478	Ward 12	12	278
2479	Ward 13	13	278
2480	Ward 14	14	278
2481	Ward 15	15	278
2482	Ward 16	16	278
2483	Ward 17	17	278
2484	Ward 18	18	278
2485	Ward 19	19	278
2486	Ward 20	20	278
2487	Ward 21	21	278
2488	Ward 22	22	278
2489	Ward 23	23	278
2490	Ward 24	24	278
2491	Ward 25	25	278
2492	Ward 26	26	278
2493	Ward 27	27	278
2494	Ward 28	28	278
2495	Ward 29	29	278
2496	Ward 1	1	279
2497	Ward 2	2	279
2498	Ward 3	3	279
2499	Ward 4	4	279
2500	Ward 5	5	279
2501	Ward 6	6	279
2502	Ward 7	7	279
2503	Ward 8	8	279
2504	Ward 9	9	279
2505	Ward 10	10	279
2506	Ward 11	11	279
2507	Ward 1	1	280
2508	Ward 2	2	280
2509	Ward 3	3	280
2510	Ward 4	4	280
2511	Ward 5	5	280
2512	Ward 6	6	280
2513	Ward 7	7	280
2514	Ward 8	8	280
2515	Ward 9	9	280
2516	Ward 10	10	280
2517	Ward 11	11	280
2518	Ward 12	12	280
2519	Ward 13	13	280
2520	Ward 1	1	281
2521	Ward 2	2	281
2522	Ward 3	3	281
2523	Ward 4	4	281
2524	Ward 5	5	281
2525	Ward 6	6	281
2526	Ward 7	7	281
2527	Ward 8	8	281
2528	Ward 9	9	281
2529	Ward 1	1	282
2530	Ward 2	2	282
2531	Ward 3	3	282
2532	Ward 4	4	282
2533	Ward 5	5	282
2534	Ward 6	6	282
2535	Ward 7	7	282
2536	Ward 8	8	282
2537	Ward 9	9	282
2538	Ward 10	10	282
2539	Ward 11	11	282
2540	Ward 12	12	282
2541	Ward 13	13	282
2542	Ward 14	14	282
2543	Ward 15	15	282
2544	Ward 16	16	282
2545	Ward 1	1	283
2546	Ward 2	2	283
2547	Ward 3	3	283
2548	Ward 4	4	283
2549	Ward 5	5	283
2550	Ward 6	6	283
2551	Ward 7	7	283
2552	Ward 8	8	283
2553	Ward 9	9	283
2554	Ward 10	10	283
2555	Ward 11	11	283
2556	Ward 12	12	283
2557	Ward 13	13	283
2558	Ward 1	1	284
2559	Ward 2	2	284
2560	Ward 3	3	284
2561	Ward 4	4	284
2562	Ward 5	5	284
2563	Ward 6	6	284
2564	Ward 7	7	284
2565	Ward 1	1	285
2566	Ward 2	2	285
2567	Ward 3	3	285
2568	Ward 4	4	285
2569	Ward 5	5	285
2570	Ward 6	6	285
2571	Ward 7	7	285
2572	Ward 8	8	285
2573	Ward 9	9	285
2574	Ward 1	1	286
2575	Ward 2	2	286
2576	Ward 3	3	286
2577	Ward 4	4	286
2578	Ward 5	5	286
2579	Ward 6	6	286
2580	Ward 7	7	286
2581	Ward 8	8	286
2582	Ward 9	9	286
2583	Ward 10	10	286
2584	Ward 11	11	286
2585	Ward 12	12	286
2586	Ward 13	13	286
2587	Ward 14	14	286
2588	Ward 1	1	287
2589	Ward 2	2	287
2590	Ward 3	3	287
2591	Ward 4	4	287
2592	Ward 5	5	287
2593	Ward 1	1	288
2594	Ward 2	2	288
2595	Ward 3	3	288
2596	Ward 4	4	288
2597	Ward 5	5	288
2598	Ward 6	6	288
2599	Ward 7	7	288
2600	Ward 8	8	288
2601	Ward 1	1	289
2602	Ward 2	2	289
2603	Ward 3	3	289
2604	Ward 4	4	289
2605	Ward 5	5	289
2606	Ward 6	6	289
2607	Ward 7	7	289
2608	Ward 8	8	289
2609	Ward 1	1	290
2610	Ward 2	2	290
2611	Ward 3	3	290
2612	Ward 4	4	290
2613	Ward 5	5	290
2614	Ward 6	6	290
2615	Ward 7	7	290
2616	Ward 1	1	291
2617	Ward 2	2	291
2618	Ward 3	3	291
2619	Ward 4	4	291
2620	Ward 5	5	291
2621	Ward 6	6	291
2622	Ward 7	7	291
2623	Ward 1	1	292
2624	Ward 2	2	292
2625	Ward 3	3	292
2626	Ward 4	4	292
2627	Ward 5	5	292
2628	Ward 6	6	292
2629	Ward 7	7	292
2630	Ward 8	8	292
2631	Ward 9	9	292
2632	Ward 10	10	292
2633	Ward 11	11	292
2634	Ward 1	1	293
2635	Ward 2	2	293
2636	Ward 3	3	293
2637	Ward 4	4	293
2638	Ward 5	5	293
2639	Ward 1	1	294
2640	Ward 2	2	294
2641	Ward 3	3	294
2642	Ward 4	4	294
2643	Ward 5	5	294
2644	Ward 6	6	294
2645	Ward 7	7	294
2646	Ward 8	8	294
2647	Ward 9	9	294
2648	Ward 10	10	294
2649	Ward 1	1	295
2650	Ward 2	2	295
2651	Ward 3	3	295
2652	Ward 4	4	295
2653	Ward 5	5	295
2654	Ward 6	6	295
2655	Ward 1	1	296
2656	Ward 2	2	296
2657	Ward 3	3	296
2658	Ward 4	4	296
2659	Ward 5	5	296
2660	Ward 6	6	296
2661	Ward 7	7	296
2662	Ward 1	1	297
2663	Ward 2	2	297
2664	Ward 3	3	297
2665	Ward 4	4	297
2666	Ward 5	5	297
2667	Ward 6	6	297
2668	Ward 7	7	297
2669	Ward 1	1	298
2670	Ward 2	2	298
2671	Ward 3	3	298
2672	Ward 4	4	298
2673	Ward 5	5	298
2674	Ward 6	6	298
2675	Ward 7	7	298
2676	Ward 8	8	298
2677	Ward 9	9	298
2678	Ward 1	1	299
2679	Ward 2	2	299
2680	Ward 3	3	299
2681	Ward 4	4	299
2682	Ward 5	5	299
2683	Ward 6	6	299
2684	Ward 7	7	299
2685	Ward 8	8	299
2686	Ward 9	9	299
2687	Ward 1	1	300
2688	Ward 2	2	300
2689	Ward 3	3	300
2690	Ward 4	4	300
2691	Ward 5	5	300
2692	Ward 6	6	300
2693	Ward 7	7	300
2694	Ward 8	8	300
2695	Ward 9	9	300
2696	Ward 1	1	301
2697	Ward 2	2	301
2698	Ward 3	3	301
2699	Ward 4	4	301
2700	Ward 5	5	301
2701	Ward 6	6	301
2702	Ward 7	7	301
2703	Ward 1	1	302
2704	Ward 2	2	302
2705	Ward 3	3	302
2706	Ward 4	4	302
2707	Ward 5	5	302
2708	Ward 6	6	302
2709	Ward 7	7	302
2710	Ward 8	8	302
2711	Ward 1	1	303
2712	Ward 2	2	303
2713	Ward 3	3	303
2714	Ward 4	4	303
2715	Ward 5	5	303
2716	Ward 6	6	303
2717	Ward 7	7	303
2718	Ward 8	8	303
2719	Ward 9	9	303
2720	Ward 1	1	304
2721	Ward 2	2	304
2722	Ward 3	3	304
2723	Ward 4	4	304
2724	Ward 5	5	304
2725	Ward 6	6	304
2726	Ward 7	7	304
2727	Ward 8	8	304
2728	Ward 1	1	305
2729	Ward 2	2	305
2730	Ward 3	3	305
2731	Ward 4	4	305
2732	Ward 5	5	305
2733	Ward 6	6	305
2734	Ward 7	7	305
2735	Ward 8	8	305
2736	Ward 1	1	306
2737	Ward 2	2	306
2738	Ward 3	3	306
2739	Ward 4	4	306
2740	Ward 5	5	306
2741	Ward 6	6	306
2742	Ward 7	7	306
2743	Ward 1	1	307
2744	Ward 2	2	307
2745	Ward 3	3	307
2746	Ward 4	4	307
2747	Ward 5	5	307
2748	Ward 6	6	307
2749	Ward 7	7	307
2750	Ward 8	8	307
2751	Ward 9	9	307
2752	Ward 10	10	307
2753	Ward 11	11	307
2754	Ward 12	12	307
2755	Ward 13	13	307
2756	Ward 14	14	307
2757	Ward 15	15	307
2758	Ward 16	16	307
2759	Ward 17	17	307
2760	Ward 18	18	307
2761	Ward 19	19	307
2762	Ward 20	20	307
2763	Ward 21	21	307
2764	Ward 22	22	307
2765	Ward 23	23	307
2766	Ward 24	24	307
2767	Ward 25	25	307
2768	Ward 26	26	307
2769	Ward 27	27	307
2770	Ward 28	28	307
2771	Ward 29	29	307
2772	Ward 30	30	307
2773	Ward 31	31	307
2774	Ward 32	32	307
2775	Ward 1	1	308
2776	Ward 2	2	308
2777	Ward 3	3	308
2778	Ward 4	4	308
2779	Ward 5	5	308
2780	Ward 6	6	308
2781	Ward 7	7	308
2782	Ward 8	8	308
2783	Ward 9	9	308
2784	Ward 1	1	309
2785	Ward 2	2	309
2786	Ward 3	3	309
2787	Ward 4	4	309
2788	Ward 5	5	309
2789	Ward 6	6	309
2790	Ward 7	7	309
2791	Ward 8	8	309
2792	Ward 9	9	309
2793	Ward 10	10	309
2794	Ward 1	1	310
2795	Ward 2	2	310
2796	Ward 3	3	310
2797	Ward 4	4	310
2798	Ward 5	5	310
2799	Ward 6	6	310
2800	Ward 7	7	310
2801	Ward 8	8	310
2802	Ward 9	9	310
2803	Ward 1	1	311
2804	Ward 2	2	311
2805	Ward 3	3	311
2806	Ward 4	4	311
2807	Ward 5	5	311
2808	Ward 6	6	311
2809	Ward 7	7	311
2810	Ward 8	8	311
2811	Ward 9	9	311
2812	Ward 10	10	311
2813	Ward 11	11	311
2814	Ward 12	12	311
2815	Ward 13	13	311
2816	Ward 14	14	311
2817	Ward 15	15	311
2818	Ward 1	1	312
2819	Ward 2	2	312
2820	Ward 3	3	312
2821	Ward 4	4	312
2822	Ward 5	5	312
2823	Ward 6	6	312
2824	Ward 7	7	312
2825	Ward 8	8	312
2826	Ward 9	9	312
2827	Ward 10	10	312
2828	Ward 11	11	312
2829	Ward 1	1	313
2830	Ward 2	2	313
2831	Ward 3	3	313
2832	Ward 4	4	313
2833	Ward 5	5	313
2834	Ward 6	6	313
2835	Ward 7	7	313
2836	Ward 8	8	313
2837	Ward 9	9	313
2838	Ward 10	10	313
2839	Ward 11	11	313
2840	Ward 1	1	314
2841	Ward 2	2	314
2842	Ward 3	3	314
2843	Ward 4	4	314
2844	Ward 5	5	314
2845	Ward 6	6	314
2846	Ward 7	7	314
2847	Ward 8	8	314
2848	Ward 9	9	314
2849	Ward 1	1	315
2850	Ward 2	2	315
2851	Ward 3	3	315
2852	Ward 4	4	315
2853	Ward 5	5	315
2854	Ward 6	6	315
2855	Ward 7	7	315
2856	Ward 8	8	315
2857	Ward 9	9	315
2858	Ward 10	10	315
2859	Ward 1	1	316
2860	Ward 2	2	316
2861	Ward 3	3	316
2862	Ward 4	4	316
2863	Ward 5	5	316
2864	Ward 6	6	316
2865	Ward 7	7	316
2866	Ward 8	8	316
2867	Ward 9	9	316
2868	Ward 10	10	316
2869	Ward 11	11	316
2870	Ward 12	12	316
2871	Ward 13	13	316
2872	Ward 1	1	317
2873	Ward 2	2	317
2874	Ward 3	3	317
2875	Ward 4	4	317
2876	Ward 5	5	317
2877	Ward 6	6	317
2878	Ward 7	7	317
2879	Ward 8	8	317
2880	Ward 9	9	317
2881	Ward 1	1	318
2882	Ward 2	2	318
2883	Ward 3	3	318
2884	Ward 4	4	318
2885	Ward 5	5	318
2886	Ward 6	6	318
2887	Ward 7	7	318
2888	Ward 8	8	318
2889	Ward 9	9	318
2890	Ward 10	10	318
2891	Ward 11	11	318
2892	Ward 12	12	318
2893	Ward 1	1	319
2894	Ward 2	2	319
2895	Ward 3	3	319
2896	Ward 4	4	319
2897	Ward 5	5	319
2898	Ward 6	6	319
2899	Ward 7	7	319
2900	Ward 8	8	319
2901	Ward 9	9	319
2902	Ward 10	10	319
2903	Ward 11	11	319
2904	Ward 1	1	320
2905	Ward 2	2	320
2906	Ward 3	3	320
2907	Ward 4	4	320
2908	Ward 5	5	320
2909	Ward 6	6	320
2910	Ward 7	7	320
2911	Ward 8	8	320
2912	Ward 9	9	320
2913	Ward 10	10	320
2914	Ward 11	11	320
2915	Ward 12	12	320
2916	Ward 1	1	321
2917	Ward 2	2	321
2918	Ward 3	3	321
2919	Ward 4	4	321
2920	Ward 5	5	321
2921	Ward 6	6	321
2922	Ward 7	7	321
2923	Ward 8	8	321
2924	Ward 9	9	321
2925	Ward 10	10	321
2926	Ward 11	11	321
2927	Ward 12	12	321
2928	Ward 13	13	321
2929	Ward 1	1	322
2930	Ward 2	2	322
2931	Ward 3	3	322
2932	Ward 4	4	322
2933	Ward 5	5	322
2934	Ward 6	6	322
2935	Ward 7	7	322
2936	Ward 8	8	322
2937	Ward 9	9	322
2938	Ward 10	10	322
2939	Ward 11	11	322
2940	Ward 12	12	322
2941	Ward 13	13	322
2942	Ward 14	14	322
2943	Ward 1	1	323
2944	Ward 2	2	323
2945	Ward 3	3	323
2946	Ward 4	4	323
2947	Ward 5	5	323
2948	Ward 6	6	323
2949	Ward 7	7	323
2950	Ward 8	8	323
2951	Ward 9	9	323
2952	Ward 10	10	323
2953	Ward 11	11	323
2954	Ward 12	12	323
2955	Ward 1	1	324
2956	Ward 2	2	324
2957	Ward 3	3	324
2958	Ward 4	4	324
2959	Ward 5	5	324
2960	Ward 6	6	324
2961	Ward 7	7	324
2962	Ward 1	1	325
2963	Ward 2	2	325
2964	Ward 3	3	325
2965	Ward 4	4	325
2966	Ward 5	5	325
2967	Ward 6	6	325
2968	Ward 7	7	325
2969	Ward 8	8	325
2970	Ward 9	9	325
2971	Ward 1	1	326
2972	Ward 2	2	326
2973	Ward 3	3	326
2974	Ward 4	4	326
2975	Ward 5	5	326
2976	Ward 6	6	326
2977	Ward 7	7	326
2978	Ward 8	8	326
2979	Ward 9	9	326
2980	Ward 1	1	327
2981	Ward 2	2	327
2982	Ward 3	3	327
2983	Ward 4	4	327
2984	Ward 1	1	328
2985	Ward 2	2	328
2986	Ward 3	3	328
2987	Ward 4	4	328
2988	Ward 5	5	328
2989	Ward 6	6	328
2990	Ward 7	7	328
2991	Ward 8	8	328
2992	Ward 9	9	328
2993	Ward 10	10	328
2994	Ward 1	1	329
2995	Ward 2	2	329
2996	Ward 3	3	329
2997	Ward 4	4	329
2998	Ward 5	5	329
2999	Ward 6	6	329
3000	Ward 7	7	329
3001	Ward 8	8	329
3002	Ward 1	1	330
3003	Ward 2	2	330
3004	Ward 3	3	330
3005	Ward 4	4	330
3006	Ward 5	5	330
3007	Ward 6	6	330
3008	Ward 7	7	330
3009	Ward 8	8	330
3010	Ward 9	9	330
3011	Ward 10	10	330
3012	Ward 11	11	330
3013	Ward 12	12	330
3014	Ward 1	1	331
3015	Ward 2	2	331
3016	Ward 3	3	331
3017	Ward 4	4	331
3018	Ward 5	5	331
3019	Ward 6	6	331
3020	Ward 7	7	331
3021	Ward 8	8	331
3022	Ward 9	9	331
3023	Ward 10	10	331
3024	Ward 11	11	331
3025	Ward 12	12	331
3026	Ward 13	13	331
3027	Ward 14	14	331
3028	Ward 15	15	331
3029	Ward 16	16	331
3030	Ward 17	17	331
3031	Ward 18	18	331
3032	Ward 19	19	331
3033	Ward 20	20	331
3034	Ward 21	21	331
3035	Ward 22	22	331
3036	Ward 23	23	331
3037	Ward 24	24	331
3038	Ward 25	25	331
3039	Ward 26	26	331
3040	Ward 27	27	331
3041	Ward 28	28	331
3042	Ward 29	29	331
3043	Ward 1	1	332
3044	Ward 2	2	332
3045	Ward 3	3	332
3046	Ward 4	4	332
3047	Ward 5	5	332
3048	Ward 6	6	332
3049	Ward 7	7	332
3050	Ward 8	8	332
3051	Ward 9	9	332
3052	Ward 10	10	332
3053	Ward 1	1	333
3054	Ward 2	2	333
3055	Ward 3	3	333
3056	Ward 4	4	333
3057	Ward 5	5	333
3058	Ward 6	6	333
3059	Ward 7	7	333
3060	Ward 8	8	333
3061	Ward 9	9	333
3062	Ward 10	10	333
3063	Ward 11	11	333
3064	Ward 12	12	333
3065	Ward 13	13	333
3066	Ward 14	14	333
3067	Ward 1	1	334
3068	Ward 2	2	334
3069	Ward 3	3	334
3070	Ward 4	4	334
3071	Ward 5	5	334
3072	Ward 1	1	335
3073	Ward 2	2	335
3074	Ward 3	3	335
3075	Ward 4	4	335
3076	Ward 5	5	335
3077	Ward 6	6	335
3078	Ward 7	7	335
3079	Ward 1	1	336
3080	Ward 2	2	336
3081	Ward 3	3	336
3082	Ward 4	4	336
3083	Ward 5	5	336
3084	Ward 6	6	336
3085	Ward 1	1	337
3086	Ward 2	2	337
3087	Ward 3	3	337
3088	Ward 4	4	337
3089	Ward 5	5	337
3090	Ward 6	6	337
3091	Ward 7	7	337
3092	Ward 8	8	337
3093	Ward 9	9	337
3094	Ward 10	10	337
3095	Ward 11	11	337
3096	Ward 12	12	337
3097	Ward 13	13	337
3098	Ward 14	14	337
3099	Ward 15	15	337
3100	Ward 16	16	337
3101	Ward 17	17	337
3102	Ward 18	18	337
3103	Ward 19	19	337
3104	Ward 1	1	338
3105	Ward 2	2	338
3106	Ward 3	3	338
3107	Ward 4	4	338
3108	Ward 5	5	338
3109	Ward 6	6	338
3110	Ward 7	7	338
3111	Ward 8	8	338
3112	Ward 9	9	338
3113	Ward 10	10	338
3114	Ward 11	11	338
3115	Ward 12	12	338
3116	Ward 1	1	339
3117	Ward 2	2	339
3118	Ward 3	3	339
3119	Ward 4	4	339
3120	Ward 5	5	339
3121	Ward 6	6	339
3122	Ward 7	7	339
3123	Ward 8	8	339
3124	Ward 9	9	339
3125	Ward 1	1	340
3126	Ward 2	2	340
3127	Ward 3	3	340
3128	Ward 4	4	340
3129	Ward 5	5	340
3130	Ward 6	6	340
3131	Ward 7	7	340
3132	Ward 8	8	340
3133	Ward 1	1	341
3134	Ward 2	2	341
3135	Ward 3	3	341
3136	Ward 4	4	341
3137	Ward 5	5	341
3138	Ward 6	6	341
3139	Ward 7	7	341
3140	Ward 8	8	341
3141	Ward 9	9	341
3142	Ward 1	1	342
3143	Ward 2	2	342
3144	Ward 3	3	342
3145	Ward 4	4	342
3146	Ward 5	5	342
3147	Ward 6	6	342
3148	Ward 7	7	342
3149	Ward 8	8	342
3150	Ward 9	9	342
3151	Ward 1	1	343
3152	Ward 2	2	343
3153	Ward 3	3	343
3154	Ward 4	4	343
3155	Ward 5	5	343
3156	Ward 6	6	343
3157	Ward 7	7	343
3158	Ward 8	8	343
3159	Ward 9	9	343
3160	Ward 10	10	343
3161	Ward 11	11	343
3162	Ward 12	12	343
3163	Ward 1	1	344
3164	Ward 2	2	344
3165	Ward 3	3	344
3166	Ward 4	4	344
3167	Ward 5	5	344
3168	Ward 6	6	344
3169	Ward 7	7	344
3170	Ward 8	8	344
3171	Ward 9	9	344
3172	Ward 1	1	345
3173	Ward 2	2	345
3174	Ward 3	3	345
3175	Ward 4	4	345
3176	Ward 5	5	345
3177	Ward 6	6	345
3178	Ward 7	7	345
3179	Ward 8	8	345
3180	Ward 9	9	345
3181	Ward 10	10	345
3182	Ward 1	1	346
3183	Ward 2	2	346
3184	Ward 3	3	346
3185	Ward 4	4	346
3186	Ward 5	5	346
3187	Ward 1	1	347
3188	Ward 2	2	347
3189	Ward 3	3	347
3190	Ward 4	4	347
3191	Ward 5	5	347
3192	Ward 6	6	347
3193	Ward 7	7	347
3194	Ward 8	8	347
3195	Ward 9	9	347
3196	Ward 10	10	347
3197	Ward 11	11	347
3198	Ward 12	12	347
3199	Ward 13	13	347
3200	Ward 1	1	348
3201	Ward 2	2	348
3202	Ward 3	3	348
3203	Ward 4	4	348
3204	Ward 5	5	348
3205	Ward 6	6	348
3206	Ward 7	7	348
3207	Ward 8	8	348
3208	Ward 9	9	348
3209	Ward 10	10	348
3210	Ward 11	11	348
3211	Ward 12	12	348
3212	Ward 13	13	348
3213	Ward 1	1	349
3214	Ward 2	2	349
3215	Ward 3	3	349
3216	Ward 4	4	349
3217	Ward 5	5	349
3218	Ward 6	6	349
3219	Ward 7	7	349
3220	Ward 8	8	349
3221	Ward 1	1	350
3222	Ward 2	2	350
3223	Ward 3	3	350
3224	Ward 4	4	350
3225	Ward 5	5	350
3226	Ward 1	1	351
3227	Ward 2	2	351
3228	Ward 3	3	351
3229	Ward 4	4	351
3230	Ward 5	5	351
3231	Ward 6	6	351
3232	Ward 1	1	352
3233	Ward 2	2	352
3234	Ward 3	3	352
3235	Ward 4	4	352
3236	Ward 5	5	352
3237	Ward 6	6	352
3238	Ward 7	7	352
3239	Ward 1	1	353
3240	Ward 2	2	353
3241	Ward 3	3	353
3242	Ward 4	4	353
3243	Ward 5	5	353
3244	Ward 6	6	353
3245	Ward 7	7	353
3246	Ward 8	8	353
3247	Ward 1	1	354
3248	Ward 2	2	354
3249	Ward 3	3	354
3250	Ward 4	4	354
3251	Ward 5	5	354
3252	Ward 6	6	354
3253	Ward 1	1	355
3254	Ward 2	2	355
3255	Ward 3	3	355
3256	Ward 4	4	355
3257	Ward 5	5	355
3258	Ward 1	1	356
3259	Ward 2	2	356
3260	Ward 3	3	356
3261	Ward 4	4	356
3262	Ward 5	5	356
3263	Ward 6	6	356
3264	Ward 1	1	357
3265	Ward 2	2	357
3266	Ward 3	3	357
3267	Ward 4	4	357
3268	Ward 5	5	357
3269	Ward 1	1	358
3270	Ward 2	2	358
3271	Ward 3	3	358
3272	Ward 4	4	358
3273	Ward 5	5	358
3274	Ward 6	6	358
3275	Ward 1	1	359
3276	Ward 2	2	359
3277	Ward 3	3	359
3278	Ward 4	4	359
3279	Ward 5	5	359
3280	Ward 6	6	359
3281	Ward 7	7	359
3282	Ward 8	8	359
3283	Ward 9	9	359
3284	Ward 10	10	359
3285	Ward 11	11	359
3286	Ward 12	12	359
3287	Ward 13	13	359
3288	Ward 14	14	359
3289	Ward 1	1	360
3290	Ward 2	2	360
3291	Ward 3	3	360
3292	Ward 4	4	360
3293	Ward 5	5	360
3294	Ward 6	6	360
3295	Ward 7	7	360
3296	Ward 8	8	360
3297	Ward 9	9	360
3298	Ward 1	1	361
3299	Ward 2	2	361
3300	Ward 3	3	361
3301	Ward 4	4	361
3302	Ward 5	5	361
3303	Ward 6	6	361
3304	Ward 7	7	361
3305	Ward 1	1	362
3306	Ward 2	2	362
3307	Ward 3	3	362
3308	Ward 4	4	362
3309	Ward 5	5	362
3310	Ward 6	6	362
3311	Ward 7	7	362
3312	Ward 8	8	362
3313	Ward 9	9	362
3314	Ward 1	1	363
3315	Ward 2	2	363
3316	Ward 3	3	363
3317	Ward 4	4	363
3318	Ward 5	5	363
3319	Ward 6	6	363
3320	Ward 7	7	363
3321	Ward 1	1	364
3322	Ward 2	2	364
3323	Ward 3	3	364
3324	Ward 4	4	364
3325	Ward 5	5	364
3326	Ward 6	6	364
3327	Ward 1	1	365
3328	Ward 2	2	365
3329	Ward 3	3	365
3330	Ward 4	4	365
3331	Ward 5	5	365
3332	Ward 6	6	365
3333	Ward 7	7	365
3334	Ward 1	1	366
3335	Ward 2	2	366
3336	Ward 3	3	366
3337	Ward 4	4	366
3338	Ward 5	5	366
3339	Ward 1	1	367
3340	Ward 2	2	367
3341	Ward 3	3	367
3342	Ward 4	4	367
3343	Ward 5	5	367
3344	Ward 1	1	368
3345	Ward 2	2	368
3346	Ward 3	3	368
3347	Ward 4	4	368
3348	Ward 5	5	368
3349	Ward 6	6	368
3350	Ward 1	1	369
3351	Ward 2	2	369
3352	Ward 3	3	369
3353	Ward 4	4	369
3354	Ward 5	5	369
3355	Ward 6	6	369
3356	Ward 1	1	370
3357	Ward 2	2	370
3358	Ward 3	3	370
3359	Ward 4	4	370
3360	Ward 5	5	370
3361	Ward 1	1	371
3362	Ward 2	2	371
3363	Ward 3	3	371
3364	Ward 4	4	371
3365	Ward 5	5	371
3366	Ward 1	1	372
3367	Ward 2	2	372
3368	Ward 3	3	372
3369	Ward 4	4	372
3370	Ward 5	5	372
3371	Ward 6	6	372
3372	Ward 7	7	372
3373	Ward 8	8	372
3374	Ward 9	9	372
3375	Ward 10	10	372
3376	Ward 11	11	372
3377	Ward 12	12	372
3378	Ward 13	13	372
3379	Ward 14	14	372
3380	Ward 1	1	373
3381	Ward 2	2	373
3382	Ward 3	3	373
3383	Ward 4	4	373
3384	Ward 5	5	373
3385	Ward 6	6	373
3386	Ward 7	7	373
3387	Ward 8	8	373
3388	Ward 9	9	373
3389	Ward 10	10	373
3390	Ward 11	11	373
3391	Ward 12	12	373
3392	Ward 13	13	373
3393	Ward 14	14	373
3394	Ward 1	1	374
3395	Ward 2	2	374
3396	Ward 3	3	374
3397	Ward 4	4	374
3398	Ward 5	5	374
3399	Ward 6	6	374
3400	Ward 7	7	374
3401	Ward 1	1	375
3402	Ward 2	2	375
3403	Ward 3	3	375
3404	Ward 4	4	375
3405	Ward 5	5	375
3406	Ward 6	6	375
3407	Ward 7	7	375
3408	Ward 8	8	375
3409	Ward 1	1	376
3410	Ward 2	2	376
3411	Ward 3	3	376
3412	Ward 4	4	376
3413	Ward 5	5	376
3414	Ward 6	6	376
3415	Ward 7	7	376
3416	Ward 8	8	376
3417	Ward 9	9	376
3418	Ward 10	10	376
3419	Ward 11	11	376
3420	Ward 1	1	377
3421	Ward 2	2	377
3422	Ward 3	3	377
3423	Ward 4	4	377
3424	Ward 5	5	377
3425	Ward 6	6	377
3426	Ward 7	7	377
3427	Ward 1	1	378
3428	Ward 2	2	378
3429	Ward 3	3	378
3430	Ward 4	4	378
3431	Ward 5	5	378
3432	Ward 6	6	378
3433	Ward 7	7	378
3434	Ward 1	1	379
3435	Ward 2	2	379
3436	Ward 3	3	379
3437	Ward 4	4	379
3438	Ward 5	5	379
3439	Ward 6	6	379
3440	Ward 1	1	380
3441	Ward 2	2	380
3442	Ward 3	3	380
3443	Ward 4	4	380
3444	Ward 5	5	380
3445	Ward 1	1	381
3446	Ward 2	2	381
3447	Ward 3	3	381
3448	Ward 4	4	381
3449	Ward 5	5	381
3450	Ward 6	6	381
3451	Ward 7	7	381
3452	Ward 8	8	381
3453	Ward 9	9	381
3454	Ward 10	10	381
3455	Ward 11	11	381
3456	Ward 12	12	381
3457	Ward 13	13	381
3458	Ward 14	14	381
3459	Ward 1	1	382
3460	Ward 2	2	382
3461	Ward 3	3	382
3462	Ward 4	4	382
3463	Ward 5	5	382
3464	Ward 6	6	382
3465	Ward 7	7	382
3466	Ward 8	8	382
3467	Ward 9	9	382
3468	Ward 1	1	383
3469	Ward 2	2	383
3470	Ward 3	3	383
3471	Ward 4	4	383
3472	Ward 5	5	383
3473	Ward 6	6	383
3474	Ward 7	7	383
3475	Ward 8	8	383
3476	Ward 9	9	383
3477	Ward 10	10	383
3478	Ward 11	11	383
3479	Ward 12	12	383
3480	Ward 13	13	383
3481	Ward 1	1	384
3482	Ward 2	2	384
3483	Ward 3	3	384
3484	Ward 4	4	384
3485	Ward 5	5	384
3486	Ward 6	6	384
3487	Ward 7	7	384
3488	Ward 8	8	384
3489	Ward 1	1	385
3490	Ward 2	2	385
3491	Ward 3	3	385
3492	Ward 4	4	385
3493	Ward 5	5	385
3494	Ward 6	6	385
3495	Ward 7	7	385
3496	Ward 1	1	386
3497	Ward 2	2	386
3498	Ward 3	3	386
3499	Ward 4	4	386
3500	Ward 5	5	386
3501	Ward 6	6	386
3502	Ward 7	7	386
3503	Ward 8	8	386
3504	Ward 9	9	386
3505	Ward 10	10	386
3506	Ward 11	11	386
3507	Ward 12	12	386
3508	Ward 1	1	387
3509	Ward 2	2	387
3510	Ward 3	3	387
3511	Ward 4	4	387
3512	Ward 5	5	387
3513	Ward 6	6	387
3514	Ward 7	7	387
3515	Ward 1	1	388
3516	Ward 2	2	388
3517	Ward 3	3	388
3518	Ward 4	4	388
3519	Ward 5	5	388
3520	Ward 6	6	388
3521	Ward 7	7	388
3522	Ward 8	8	388
3523	Ward 1	1	389
3524	Ward 2	2	389
3525	Ward 3	3	389
3526	Ward 4	4	389
3527	Ward 5	5	389
3528	Ward 1	1	390
3529	Ward 2	2	390
3530	Ward 3	3	390
3531	Ward 4	4	390
3532	Ward 5	5	390
3533	Ward 6	6	390
3534	Ward 7	7	390
3535	Ward 1	1	391
3536	Ward 2	2	391
3537	Ward 3	3	391
3538	Ward 4	4	391
3539	Ward 5	5	391
3540	Ward 6	6	391
3541	Ward 7	7	391
3542	Ward 1	1	392
3543	Ward 2	2	392
3544	Ward 3	3	392
3545	Ward 4	4	392
3546	Ward 5	5	392
3547	Ward 6	6	392
3548	Ward 1	1	393
3549	Ward 2	2	393
3550	Ward 3	3	393
3551	Ward 4	4	393
3552	Ward 5	5	393
3553	Ward 6	6	393
3554	Ward 7	7	393
3555	Ward 8	8	393
3556	Ward 9	9	393
3557	Ward 10	10	393
3558	Ward 11	11	393
3559	Ward 12	12	393
3560	Ward 13	13	393
3561	Ward 14	14	393
3562	Ward 1	1	394
3563	Ward 2	2	394
3564	Ward 3	3	394
3565	Ward 4	4	394
3566	Ward 5	5	394
3567	Ward 6	6	394
3568	Ward 7	7	394
3569	Ward 8	8	394
3570	Ward 9	9	394
3571	Ward 1	1	395
3572	Ward 2	2	395
3573	Ward 3	3	395
3574	Ward 4	4	395
3575	Ward 5	5	395
3576	Ward 6	6	395
3577	Ward 7	7	395
3578	Ward 8	8	395
3579	Ward 9	9	395
3580	Ward 10	10	395
3581	Ward 11	11	395
3582	Ward 1	1	396
3583	Ward 2	2	396
3584	Ward 3	3	396
3585	Ward 4	4	396
3586	Ward 5	5	396
3587	Ward 6	6	396
3588	Ward 7	7	396
3589	Ward 8	8	396
3590	Ward 9	9	396
3591	Ward 10	10	396
3592	Ward 1	1	397
3593	Ward 2	2	397
3594	Ward 3	3	397
3595	Ward 4	4	397
3596	Ward 5	5	397
3597	Ward 1	1	398
3598	Ward 2	2	398
3599	Ward 3	3	398
3600	Ward 4	4	398
3601	Ward 5	5	398
3602	Ward 6	6	398
3603	Ward 7	7	398
3604	Ward 8	8	398
3605	Ward 1	1	399
3606	Ward 2	2	399
3607	Ward 3	3	399
3608	Ward 4	4	399
3609	Ward 5	5	399
3610	Ward 6	6	399
3611	Ward 1	1	400
3612	Ward 2	2	400
3613	Ward 3	3	400
3614	Ward 4	4	400
3615	Ward 5	5	400
3616	Ward 1	1	401
3617	Ward 2	2	401
3618	Ward 3	3	401
3619	Ward 4	4	401
3620	Ward 5	5	401
3621	Ward 6	6	401
3622	Ward 7	7	401
3623	Ward 1	1	402
3624	Ward 2	2	402
3625	Ward 3	3	402
3626	Ward 4	4	402
3627	Ward 5	5	402
3628	Ward 6	6	402
3629	Ward 7	7	402
3630	Ward 8	8	402
3631	Ward 9	9	402
3632	Ward 10	10	402
3633	Ward 1	1	403
3634	Ward 2	2	403
3635	Ward 3	3	403
3636	Ward 4	4	403
3637	Ward 5	5	403
3638	Ward 6	6	403
3639	Ward 7	7	403
3640	Ward 8	8	403
3641	Ward 9	9	403
3642	Ward 10	10	403
3643	Ward 11	11	403
3644	Ward 12	12	403
3645	Ward 13	13	403
3646	Ward 14	14	403
3647	Ward 1	1	404
3648	Ward 2	2	404
3649	Ward 3	3	404
3650	Ward 4	4	404
3651	Ward 5	5	404
3652	Ward 6	6	404
3653	Ward 7	7	404
3654	Ward 8	8	404
3655	Ward 9	9	404
3656	Ward 10	10	404
3657	Ward 1	1	405
3658	Ward 2	2	405
3659	Ward 3	3	405
3660	Ward 4	4	405
3661	Ward 5	5	405
3662	Ward 6	6	405
3663	Ward 7	7	405
3664	Ward 8	8	405
3665	Ward 1	1	406
3666	Ward 2	2	406
3667	Ward 3	3	406
3668	Ward 4	4	406
3669	Ward 5	5	406
3670	Ward 6	6	406
3671	Ward 7	7	406
3672	Ward 8	8	406
3673	Ward 1	1	407
3674	Ward 2	2	407
3675	Ward 3	3	407
3676	Ward 4	4	407
3677	Ward 5	5	407
3678	Ward 1	1	408
3679	Ward 2	2	408
3680	Ward 3	3	408
3681	Ward 4	4	408
3682	Ward 5	5	408
3683	Ward 6	6	408
3684	Ward 7	7	408
3685	Ward 1	1	409
3686	Ward 2	2	409
3687	Ward 3	3	409
3688	Ward 4	4	409
3689	Ward 5	5	409
3690	Ward 6	6	409
3691	Ward 7	7	409
3692	Ward 1	1	410
3693	Ward 2	2	410
3694	Ward 3	3	410
3695	Ward 4	4	410
3696	Ward 5	5	410
3697	Ward 6	6	410
3698	Ward 7	7	410
3699	Ward 8	8	410
3700	Ward 1	1	411
3701	Ward 2	2	411
3702	Ward 3	3	411
3703	Ward 4	4	411
3704	Ward 5	5	411
3705	Ward 6	6	411
3706	Ward 7	7	411
3707	Ward 8	8	411
3708	Ward 9	9	411
3709	Ward 1	1	412
3710	Ward 2	2	412
3711	Ward 3	3	412
3712	Ward 4	4	412
3713	Ward 5	5	412
3714	Ward 6	6	412
3715	Ward 7	7	412
3716	Ward 8	8	412
3717	Ward 9	9	412
3718	Ward 10	10	412
3719	Ward 1	1	413
3720	Ward 2	2	413
3721	Ward 3	3	413
3722	Ward 4	4	413
3723	Ward 5	5	413
3724	Ward 6	6	413
3725	Ward 7	7	413
3726	Ward 8	8	413
3727	Ward 1	1	414
3728	Ward 2	2	414
3729	Ward 3	3	414
3730	Ward 4	4	414
3731	Ward 5	5	414
3732	Ward 6	6	414
3733	Ward 7	7	414
3734	Ward 8	8	414
3735	Ward 9	9	414
3736	Ward 10	10	414
3737	Ward 11	11	414
3738	Ward 12	12	414
3739	Ward 13	13	414
3740	Ward 14	14	414
3741	Ward 15	15	414
3742	Ward 16	16	414
3743	Ward 17	17	414
3744	Ward 18	18	414
3745	Ward 19	19	414
3746	Ward 20	20	414
3747	Ward 21	21	414
3748	Ward 22	22	414
3749	Ward 23	23	414
3750	Ward 24	24	414
3751	Ward 25	25	414
3752	Ward 26	26	414
3753	Ward 27	27	414
3754	Ward 28	28	414
3755	Ward 29	29	414
3756	Ward 30	30	414
3757	Ward 31	31	414
3758	Ward 32	32	414
3759	Ward 33	33	414
3760	Ward 1	1	415
3761	Ward 2	2	415
3762	Ward 3	3	415
3763	Ward 4	4	415
3764	Ward 5	5	415
3765	Ward 6	6	415
3766	Ward 7	7	415
3767	Ward 8	8	415
3768	Ward 9	9	415
3769	Ward 10	10	415
3770	Ward 11	11	415
3771	Ward 1	1	416
3772	Ward 2	2	416
3773	Ward 3	3	416
3774	Ward 4	4	416
3775	Ward 5	5	416
3776	Ward 6	6	416
3777	Ward 7	7	416
3778	Ward 8	8	416
3779	Ward 9	9	416
3780	Ward 1	1	417
3781	Ward 2	2	417
3782	Ward 3	3	417
3783	Ward 4	4	417
3784	Ward 5	5	417
3785	Ward 6	6	417
3786	Ward 7	7	417
3787	Ward 8	8	417
3788	Ward 9	9	417
3789	Ward 10	10	417
3790	Ward 11	11	417
3791	Ward 12	12	417
3792	Ward 1	1	418
3793	Ward 2	2	418
3794	Ward 3	3	418
3795	Ward 4	4	418
3796	Ward 5	5	418
3797	Ward 6	6	418
3798	Ward 7	7	418
3799	Ward 1	1	419
3800	Ward 2	2	419
3801	Ward 3	3	419
3802	Ward 4	4	419
3803	Ward 5	5	419
3804	Ward 6	6	419
3805	Ward 7	7	419
3806	Ward 8	8	419
3807	Ward 9	9	419
3808	Ward 10	10	419
3809	Ward 11	11	419
3810	Ward 1	1	420
3811	Ward 2	2	420
3812	Ward 3	3	420
3813	Ward 4	4	420
3814	Ward 5	5	420
3815	Ward 6	6	420
3816	Ward 7	7	420
3817	Ward 8	8	420
3818	Ward 9	9	420
3819	Ward 10	10	420
3820	Ward 1	1	421
3821	Ward 2	2	421
3822	Ward 3	3	421
3823	Ward 4	4	421
3824	Ward 5	5	421
3825	Ward 6	6	421
3826	Ward 7	7	421
3827	Ward 8	8	421
3828	Ward 9	9	421
3829	Ward 10	10	421
3830	Ward 1	1	422
3831	Ward 2	2	422
3832	Ward 3	3	422
3833	Ward 4	4	422
3834	Ward 5	5	422
3835	Ward 6	6	422
3836	Ward 7	7	422
3837	Ward 8	8	422
3838	Ward 9	9	422
3839	Ward 10	10	422
3840	Ward 11	11	422
3841	Ward 1	1	423
3842	Ward 2	2	423
3843	Ward 3	3	423
3844	Ward 4	4	423
3845	Ward 5	5	423
3846	Ward 6	6	423
3847	Ward 7	7	423
3848	Ward 8	8	423
3849	Ward 9	9	423
3850	Ward 1	1	424
3851	Ward 2	2	424
3852	Ward 3	3	424
3853	Ward 4	4	424
3854	Ward 5	5	424
3855	Ward 6	6	424
3856	Ward 1	1	425
3857	Ward 2	2	425
3858	Ward 3	3	425
3859	Ward 4	4	425
3860	Ward 5	5	425
3861	Ward 6	6	425
3862	Ward 7	7	425
3863	Ward 8	8	425
3864	Ward 9	9	425
3865	Ward 1	1	426
3866	Ward 2	2	426
3867	Ward 3	3	426
3868	Ward 4	4	426
3869	Ward 5	5	426
3870	Ward 6	6	426
3871	Ward 7	7	426
3872	Ward 8	8	426
3873	Ward 9	9	426
3874	Ward 1	1	427
3875	Ward 2	2	427
3876	Ward 3	3	427
3877	Ward 4	4	427
3878	Ward 5	5	427
3879	Ward 1	1	428
3880	Ward 2	2	428
3881	Ward 3	3	428
3882	Ward 4	4	428
3883	Ward 5	5	428
3884	Ward 6	6	428
3885	Ward 7	7	428
3886	Ward 8	8	428
3887	Ward 9	9	428
3888	Ward 1	1	429
3889	Ward 2	2	429
3890	Ward 3	3	429
3891	Ward 4	4	429
3892	Ward 5	5	429
3893	Ward 1	1	430
3894	Ward 2	2	430
3895	Ward 3	3	430
3896	Ward 4	4	430
3897	Ward 5	5	430
3898	Ward 6	6	430
3899	Ward 7	7	430
3900	Ward 8	8	430
3901	Ward 9	9	430
3902	Ward 1	1	431
3903	Ward 2	2	431
3904	Ward 3	3	431
3905	Ward 4	4	431
3906	Ward 5	5	431
3907	Ward 1	1	432
3908	Ward 2	2	432
3909	Ward 3	3	432
3910	Ward 4	4	432
3911	Ward 5	5	432
3912	Ward 1	1	433
3913	Ward 2	2	433
3914	Ward 3	3	433
3915	Ward 4	4	433
3916	Ward 5	5	433
3917	Ward 1	1	434
3918	Ward 2	2	434
3919	Ward 3	3	434
3920	Ward 4	4	434
3921	Ward 5	5	434
3922	Ward 1	1	435
3923	Ward 2	2	435
3924	Ward 3	3	435
3925	Ward 4	4	435
3926	Ward 5	5	435
3927	Ward 1	1	436
3928	Ward 2	2	436
3929	Ward 3	3	436
3930	Ward 4	4	436
3931	Ward 5	5	436
3932	Ward 6	6	436
3933	Ward 7	7	436
3934	Ward 8	8	436
3935	Ward 9	9	436
3936	Ward 10	10	436
3937	Ward 1	1	437
3938	Ward 2	2	437
3939	Ward 3	3	437
3940	Ward 4	4	437
3941	Ward 5	5	437
3942	Ward 6	6	437
3943	Ward 7	7	437
3944	Ward 8	8	437
3945	Ward 1	1	438
3946	Ward 2	2	438
3947	Ward 3	3	438
3948	Ward 4	4	438
3949	Ward 5	5	438
3950	Ward 6	6	438
3951	Ward 7	7	438
3952	Ward 1	1	439
3953	Ward 2	2	439
3954	Ward 3	3	439
3955	Ward 4	4	439
3956	Ward 5	5	439
3957	Ward 1	1	440
3958	Ward 2	2	440
3959	Ward 3	3	440
3960	Ward 4	4	440
3961	Ward 5	5	440
3962	Ward 6	6	440
3963	Ward 7	7	440
3964	Ward 1	1	441
3965	Ward 2	2	441
3966	Ward 3	3	441
3967	Ward 4	4	441
3968	Ward 5	5	441
3969	Ward 6	6	441
3970	Ward 7	7	441
3971	Ward 8	8	441
3972	Ward 1	1	442
3973	Ward 2	2	442
3974	Ward 3	3	442
3975	Ward 4	4	442
3976	Ward 5	5	442
3977	Ward 6	6	442
3978	Ward 7	7	442
3979	Ward 8	8	442
3980	Ward 9	9	442
3981	Ward 10	10	442
3982	Ward 11	11	442
3983	Ward 12	12	442
3984	Ward 13	13	442
3985	Ward 14	14	442
3986	Ward 15	15	442
3987	Ward 16	16	442
3988	Ward 17	17	442
3989	Ward 1	1	443
3990	Ward 2	2	443
3991	Ward 3	3	443
3992	Ward 4	4	443
3993	Ward 5	5	443
3994	Ward 6	6	443
3995	Ward 7	7	443
3996	Ward 8	8	443
3997	Ward 9	9	443
3998	Ward 10	10	443
3999	Ward 11	11	443
4000	Ward 12	12	443
4001	Ward 13	13	443
4002	Ward 14	14	443
4003	Ward 15	15	443
4004	Ward 16	16	443
4005	Ward 17	17	443
4006	Ward 18	18	443
4007	Ward 1	1	444
4008	Ward 2	2	444
4009	Ward 3	3	444
4010	Ward 4	4	444
4011	Ward 5	5	444
4012	Ward 6	6	444
4013	Ward 7	7	444
4014	Ward 8	8	444
4015	Ward 9	9	444
4016	Ward 10	10	444
4017	Ward 11	11	444
4018	Ward 12	12	444
4019	Ward 13	13	444
4020	Ward 14	14	444
4021	Ward 15	15	444
4022	Ward 16	16	444
4023	Ward 17	17	444
4024	Ward 1	1	445
4025	Ward 2	2	445
4026	Ward 3	3	445
4027	Ward 4	4	445
4028	Ward 5	5	445
4029	Ward 6	6	445
4030	Ward 7	7	445
4031	Ward 8	8	445
4032	Ward 9	9	445
4033	Ward 10	10	445
4034	Ward 11	11	445
4035	Ward 12	12	445
4036	Ward 13	13	445
4037	Ward 14	14	445
4038	Ward 15	15	445
4039	Ward 1	1	446
4040	Ward 2	2	446
4041	Ward 3	3	446
4042	Ward 4	4	446
4043	Ward 5	5	446
4044	Ward 6	6	446
4045	Ward 1	1	447
4046	Ward 2	2	447
4047	Ward 3	3	447
4048	Ward 4	4	447
4049	Ward 5	5	447
4050	Ward 6	6	447
4051	Ward 1	1	448
4052	Ward 2	2	448
4053	Ward 3	3	448
4054	Ward 4	4	448
4055	Ward 5	5	448
4056	Ward 6	6	448
4057	Ward 7	7	448
4058	Ward 1	1	449
4059	Ward 2	2	449
4060	Ward 3	3	449
4061	Ward 4	4	449
4062	Ward 5	5	449
4063	Ward 6	6	449
4064	Ward 1	1	450
4065	Ward 2	2	450
4066	Ward 3	3	450
4067	Ward 4	4	450
4068	Ward 5	5	450
4069	Ward 6	6	450
4070	Ward 7	7	450
4071	Ward 8	8	450
4072	Ward 9	9	450
4073	Ward 10	10	450
4074	Ward 11	11	450
4075	Ward 12	12	450
4076	Ward 13	13	450
4077	Ward 14	14	450
4078	Ward 1	1	451
4079	Ward 2	2	451
4080	Ward 3	3	451
4081	Ward 4	4	451
4082	Ward 5	5	451
4083	Ward 6	6	451
4084	Ward 7	7	451
4085	Ward 8	8	451
4086	Ward 9	9	451
4087	Ward 10	10	451
4088	Ward 11	11	451
4089	Ward 1	1	452
4090	Ward 2	2	452
4091	Ward 3	3	452
4092	Ward 4	4	452
4093	Ward 5	5	452
4094	Ward 6	6	452
4095	Ward 7	7	452
4096	Ward 8	8	452
4097	Ward 9	9	452
4098	Ward 1	1	453
4099	Ward 2	2	453
4100	Ward 3	3	453
4101	Ward 4	4	453
4102	Ward 5	5	453
4103	Ward 6	6	453
4104	Ward 7	7	453
4105	Ward 1	1	454
4106	Ward 2	2	454
4107	Ward 3	3	454
4108	Ward 4	4	454
4109	Ward 5	5	454
4110	Ward 6	6	454
4111	Ward 1	1	455
4112	Ward 2	2	455
4113	Ward 3	3	455
4114	Ward 4	4	455
4115	Ward 5	5	455
4116	Ward 6	6	455
4117	Ward 7	7	455
4118	Ward 8	8	455
4119	Ward 1	1	456
4120	Ward 2	2	456
4121	Ward 3	3	456
4122	Ward 4	4	456
4123	Ward 5	5	456
4124	Ward 6	6	456
4125	Ward 1	1	457
4126	Ward 2	2	457
4127	Ward 3	3	457
4128	Ward 4	4	457
4129	Ward 5	5	457
4130	Ward 6	6	457
4131	Ward 7	7	457
4132	Ward 8	8	457
4133	Ward 9	9	457
4134	Ward 10	10	457
4135	Ward 11	11	457
4136	Ward 1	1	458
4137	Ward 2	2	458
4138	Ward 3	3	458
4139	Ward 4	4	458
4140	Ward 5	5	458
4141	Ward 6	6	458
4142	Ward 7	7	458
4143	Ward 8	8	458
4144	Ward 9	9	458
4145	Ward 10	10	458
4146	Ward 1	1	459
4147	Ward 2	2	459
4148	Ward 3	3	459
4149	Ward 4	4	459
4150	Ward 5	5	459
4151	Ward 6	6	459
4152	Ward 7	7	459
4153	Ward 8	8	459
4154	Ward 9	9	459
4155	Ward 10	10	459
4156	Ward 11	11	459
4157	Ward 12	12	459
4158	Ward 13	13	459
4159	Ward 14	14	459
4160	Ward 1	1	460
4161	Ward 2	2	460
4162	Ward 3	3	460
4163	Ward 4	4	460
4164	Ward 5	5	460
4165	Ward 6	6	460
4166	Ward 7	7	460
4167	Ward 8	8	460
4168	Ward 9	9	460
4169	Ward 1	1	461
4170	Ward 2	2	461
4171	Ward 3	3	461
4172	Ward 4	4	461
4173	Ward 5	5	461
4174	Ward 6	6	461
4175	Ward 7	7	461
4176	Ward 8	8	461
4177	Ward 9	9	461
4178	Ward 10	10	461
4179	Ward 11	11	461
4180	Ward 12	12	461
4181	Ward 13	13	461
4182	Ward 14	14	461
4183	Ward 1	1	462
4184	Ward 2	2	462
4185	Ward 3	3	462
4186	Ward 4	4	462
4187	Ward 5	5	462
4188	Ward 6	6	462
4189	Ward 1	1	463
4190	Ward 2	2	463
4191	Ward 3	3	463
4192	Ward 4	4	463
4193	Ward 5	5	463
4194	Ward 6	6	463
4195	Ward 1	1	464
4196	Ward 2	2	464
4197	Ward 3	3	464
4198	Ward 4	4	464
4199	Ward 5	5	464
4200	Ward 6	6	464
4201	Ward 7	7	464
4202	Ward 1	1	465
4203	Ward 2	2	465
4204	Ward 3	3	465
4205	Ward 4	4	465
4206	Ward 5	5	465
4207	Ward 1	1	466
4208	Ward 2	2	466
4209	Ward 3	3	466
4210	Ward 4	4	466
4211	Ward 5	5	466
4212	Ward 6	6	466
4213	Ward 7	7	466
4214	Ward 1	1	467
4215	Ward 2	2	467
4216	Ward 3	3	467
4217	Ward 4	4	467
4218	Ward 5	5	467
4219	Ward 6	6	467
4220	Ward 7	7	467
4221	Ward 8	8	467
4222	Ward 1	1	468
4223	Ward 2	2	468
4224	Ward 3	3	468
4225	Ward 4	4	468
4226	Ward 5	5	468
4227	Ward 6	6	468
4228	Ward 7	7	468
4229	Ward 8	8	468
4230	Ward 9	9	468
4231	Ward 10	10	468
4232	Ward 11	11	468
4233	Ward 12	12	468
4234	Ward 13	13	468
4235	Ward 1	1	469
4236	Ward 2	2	469
4237	Ward 3	3	469
4238	Ward 4	4	469
4239	Ward 5	5	469
4240	Ward 6	6	469
4241	Ward 7	7	469
4242	Ward 8	8	469
4243	Ward 9	9	469
4244	Ward 1	1	470
4245	Ward 2	2	470
4246	Ward 3	3	470
4247	Ward 4	4	470
4248	Ward 5	5	470
4249	Ward 6	6	470
4250	Ward 7	7	470
4251	Ward 8	8	470
4252	Ward 9	9	470
4253	Ward 10	10	470
4254	Ward 11	11	470
4255	Ward 12	12	470
4256	Ward 13	13	470
4257	Ward 14	14	470
4258	Ward 1	1	471
4259	Ward 2	2	471
4260	Ward 3	3	471
4261	Ward 4	4	471
4262	Ward 5	5	471
4263	Ward 6	6	471
4264	Ward 7	7	471
4265	Ward 8	8	471
4266	Ward 9	9	471
4267	Ward 10	10	471
4268	Ward 11	11	471
4269	Ward 12	12	471
4270	Ward 1	1	472
4271	Ward 2	2	472
4272	Ward 3	3	472
4273	Ward 4	4	472
4274	Ward 5	5	472
4275	Ward 6	6	472
4276	Ward 1	1	473
4277	Ward 2	2	473
4278	Ward 3	3	473
4279	Ward 4	4	473
4280	Ward 5	5	473
4281	Ward 1	1	474
4282	Ward 2	2	474
4283	Ward 3	3	474
4284	Ward 4	4	474
4285	Ward 5	5	474
4286	Ward 6	6	474
4287	Ward 1	1	475
4288	Ward 2	2	475
4289	Ward 3	3	475
4290	Ward 4	4	475
4291	Ward 5	5	475
4292	Ward 6	6	475
4293	Ward 7	7	475
4294	Ward 8	8	475
4295	Ward 1	1	476
4296	Ward 2	2	476
4297	Ward 3	3	476
4298	Ward 4	4	476
4299	Ward 5	5	476
4300	Ward 1	1	477
4301	Ward 2	2	477
4302	Ward 3	3	477
4303	Ward 4	4	477
4304	Ward 5	5	477
4305	Ward 6	6	477
4306	Ward 7	7	477
4307	Ward 1	1	478
4308	Ward 2	2	478
4309	Ward 3	3	478
4310	Ward 4	4	478
4311	Ward 5	5	478
4312	Ward 6	6	478
4313	Ward 7	7	478
4314	Ward 8	8	478
4315	Ward 9	9	478
4316	Ward 10	10	478
4317	Ward 11	11	478
4318	Ward 12	12	478
4319	Ward 1	1	479
4320	Ward 2	2	479
4321	Ward 3	3	479
4322	Ward 4	4	479
4323	Ward 5	5	479
4324	Ward 6	6	479
4325	Ward 7	7	479
4326	Ward 8	8	479
4327	Ward 9	9	479
4328	Ward 10	10	479
4329	Ward 11	11	479
4330	Ward 1	1	480
4331	Ward 2	2	480
4332	Ward 3	3	480
4333	Ward 4	4	480
4334	Ward 5	5	480
4335	Ward 6	6	480
4336	Ward 7	7	480
4337	Ward 8	8	480
4338	Ward 9	9	480
4339	Ward 10	10	480
4340	Ward 1	1	481
4341	Ward 2	2	481
4342	Ward 3	3	481
4343	Ward 4	4	481
4344	Ward 5	5	481
4345	Ward 6	6	481
4346	Ward 7	7	481
4347	Ward 8	8	481
4348	Ward 9	9	481
4349	Ward 10	10	481
4350	Ward 11	11	481
4351	Ward 1	1	482
4352	Ward 2	2	482
4353	Ward 3	3	482
4354	Ward 4	4	482
4355	Ward 5	5	482
4356	Ward 6	6	482
4357	Ward 7	7	482
4358	Ward 8	8	482
4359	Ward 9	9	482
4360	Ward 10	10	482
4361	Ward 11	11	482
4362	Ward 12	12	482
4363	Ward 1	1	483
4364	Ward 2	2	483
4365	Ward 3	3	483
4366	Ward 4	4	483
4367	Ward 5	5	483
4368	Ward 6	6	483
4369	Ward 7	7	483
4370	Ward 8	8	483
4371	Ward 9	9	483
4372	Ward 10	10	483
4373	Ward 11	11	483
4374	Ward 1	1	484
4375	Ward 2	2	484
4376	Ward 3	3	484
4377	Ward 4	4	484
4378	Ward 5	5	484
4379	Ward 6	6	484
4380	Ward 7	7	484
4381	Ward 8	8	484
4382	Ward 1	1	485
4383	Ward 2	2	485
4384	Ward 3	3	485
4385	Ward 4	4	485
4386	Ward 5	5	485
4387	Ward 6	6	485
4388	Ward 7	7	485
4389	Ward 8	8	485
4390	Ward 1	1	486
4391	Ward 2	2	486
4392	Ward 3	3	486
4393	Ward 4	4	486
4394	Ward 5	5	486
4395	Ward 6	6	486
4396	Ward 1	1	487
4397	Ward 2	2	487
4398	Ward 3	3	487
4399	Ward 4	4	487
4400	Ward 5	5	487
4401	Ward 6	6	487
4402	Ward 7	7	487
4403	Ward 1	1	488
4404	Ward 2	2	488
4405	Ward 3	3	488
4406	Ward 4	4	488
4407	Ward 5	5	488
4408	Ward 6	6	488
4409	Ward 7	7	488
4410	Ward 8	8	488
4411	Ward 9	9	488
4412	Ward 10	10	488
4413	Ward 11	11	488
4414	Ward 12	12	488
4415	Ward 13	13	488
4416	Ward 14	14	488
4417	Ward 15	15	488
4418	Ward 16	16	488
4419	Ward 1	1	489
4420	Ward 2	2	489
4421	Ward 3	3	489
4422	Ward 4	4	489
4423	Ward 5	5	489
4424	Ward 6	6	489
4425	Ward 7	7	489
4426	Ward 8	8	489
4427	Ward 9	9	489
4428	Ward 10	10	489
4429	Ward 11	11	489
4430	Ward 12	12	489
4431	Ward 13	13	489
4432	Ward 14	14	489
4433	Ward 15	15	489
4434	Ward 16	16	489
4435	Ward 17	17	489
4436	Ward 18	18	489
4437	Ward 1	1	490
4438	Ward 2	2	490
4439	Ward 3	3	490
4440	Ward 4	4	490
4441	Ward 5	5	490
4442	Ward 6	6	490
4443	Ward 7	7	490
4444	Ward 8	8	490
4445	Ward 9	9	490
4446	Ward 10	10	490
4447	Ward 11	11	490
4448	Ward 12	12	490
4449	Ward 13	13	490
4450	Ward 1	1	491
4451	Ward 2	2	491
4452	Ward 3	3	491
4453	Ward 4	4	491
4454	Ward 5	5	491
4455	Ward 1	1	492
4456	Ward 2	2	492
4457	Ward 3	3	492
4458	Ward 4	4	492
4459	Ward 5	5	492
4460	Ward 6	6	492
4461	Ward 1	1	493
4462	Ward 2	2	493
4463	Ward 3	3	493
4464	Ward 4	4	493
4465	Ward 5	5	493
4466	Ward 6	6	493
4467	Ward 7	7	493
4468	Ward 8	8	493
4469	Ward 9	9	493
4470	Ward 1	1	494
4471	Ward 2	2	494
4472	Ward 3	3	494
4473	Ward 4	4	494
4474	Ward 5	5	494
4475	Ward 6	6	494
4476	Ward 7	7	494
4477	Ward 1	1	495
4478	Ward 2	2	495
4479	Ward 3	3	495
4480	Ward 4	4	495
4481	Ward 5	5	495
4482	Ward 6	6	495
4483	Ward 7	7	495
4484	Ward 8	8	495
4485	Ward 9	9	495
4486	Ward 10	10	495
4487	Ward 11	11	495
4488	Ward 12	12	495
4489	Ward 13	13	495
4490	Ward 14	14	495
4491	Ward 15	15	495
4492	Ward 16	16	495
4493	Ward 17	17	495
4494	Ward 18	18	495
4495	Ward 19	19	495
4496	Ward 1	1	496
4497	Ward 2	2	496
4498	Ward 3	3	496
4499	Ward 4	4	496
4500	Ward 5	5	496
4501	Ward 6	6	496
4502	Ward 7	7	496
4503	Ward 8	8	496
4504	Ward 9	9	496
4505	Ward 10	10	496
4506	Ward 11	11	496
4507	Ward 12	12	496
4508	Ward 1	1	497
4509	Ward 2	2	497
4510	Ward 3	3	497
4511	Ward 4	4	497
4512	Ward 5	5	497
4513	Ward 6	6	497
4514	Ward 7	7	497
4515	Ward 8	8	497
4516	Ward 9	9	497
4517	Ward 10	10	497
4518	Ward 11	11	497
4519	Ward 12	12	497
4520	Ward 13	13	497
4521	Ward 1	1	498
4522	Ward 2	2	498
4523	Ward 3	3	498
4524	Ward 4	4	498
4525	Ward 5	5	498
4526	Ward 6	6	498
4527	Ward 7	7	498
4528	Ward 8	8	498
4529	Ward 9	9	498
4530	Ward 10	10	498
4531	Ward 11	11	498
4532	Ward 1	1	499
4533	Ward 2	2	499
4534	Ward 3	3	499
4535	Ward 4	4	499
4536	Ward 5	5	499
4537	Ward 6	6	499
4538	Ward 7	7	499
4539	Ward 8	8	499
4540	Ward 9	9	499
4541	Ward 10	10	499
4542	Ward 11	11	499
4543	Ward 12	12	499
4544	Ward 13	13	499
4545	Ward 1	1	500
4546	Ward 2	2	500
4547	Ward 3	3	500
4548	Ward 4	4	500
4549	Ward 5	5	500
4550	Ward 6	6	500
4551	Ward 7	7	500
4552	Ward 8	8	500
4553	Ward 9	9	500
4554	Ward 10	10	500
4555	Ward 11	11	500
4556	Ward 12	12	500
4557	Ward 13	13	500
4558	Ward 14	14	500
4559	Ward 15	15	500
4560	Ward 16	16	500
4561	Ward 17	17	500
4562	Ward 1	1	501
4563	Ward 2	2	501
4564	Ward 3	3	501
4565	Ward 4	4	501
4566	Ward 5	5	501
4567	Ward 6	6	501
4568	Ward 7	7	501
4569	Ward 8	8	501
4570	Ward 9	9	501
4571	Ward 1	1	502
4572	Ward 2	2	502
4573	Ward 3	3	502
4574	Ward 4	4	502
4575	Ward 5	5	502
4576	Ward 1	1	503
4577	Ward 2	2	503
4578	Ward 3	3	503
4579	Ward 4	4	503
4580	Ward 5	5	503
4581	Ward 6	6	503
4582	Ward 7	7	503
4583	Ward 1	1	504
4584	Ward 2	2	504
4585	Ward 3	3	504
4586	Ward 4	4	504
4587	Ward 5	5	504
4588	Ward 6	6	504
4589	Ward 7	7	504
4590	Ward 1	1	505
4591	Ward 2	2	505
4592	Ward 3	3	505
4593	Ward 4	4	505
4594	Ward 5	5	505
4595	Ward 6	6	505
4596	Ward 7	7	505
4597	Ward 8	8	505
4598	Ward 1	1	506
4599	Ward 2	2	506
4600	Ward 3	3	506
4601	Ward 4	4	506
4602	Ward 5	5	506
4603	Ward 6	6	506
4604	Ward 1	1	507
4605	Ward 2	2	507
4606	Ward 3	3	507
4607	Ward 4	4	507
4608	Ward 5	5	507
4609	Ward 6	6	507
4610	Ward 7	7	507
4611	Ward 1	1	508
4612	Ward 2	2	508
4613	Ward 3	3	508
4614	Ward 4	4	508
4615	Ward 5	5	508
4616	Ward 6	6	508
4617	Ward 7	7	508
4618	Ward 1	1	509
4619	Ward 2	2	509
4620	Ward 3	3	509
4621	Ward 4	4	509
4622	Ward 5	5	509
4623	Ward 6	6	509
4624	Ward 7	7	509
4625	Ward 1	1	510
4626	Ward 2	2	510
4627	Ward 3	3	510
4628	Ward 4	4	510
4629	Ward 5	5	510
4630	Ward 6	6	510
4631	Ward 7	7	510
4632	Ward 1	1	511
4633	Ward 2	2	511
4634	Ward 3	3	511
4635	Ward 4	4	511
4636	Ward 5	5	511
4637	Ward 6	6	511
4638	Ward 7	7	511
4639	Ward 8	8	511
4640	Ward 9	9	511
4641	Ward 10	10	511
4642	Ward 11	11	511
4643	Ward 12	12	511
4644	Ward 1	1	512
4645	Ward 2	2	512
4646	Ward 3	3	512
4647	Ward 4	4	512
4648	Ward 5	5	512
4649	Ward 6	6	512
4650	Ward 7	7	512
4651	Ward 8	8	512
4652	Ward 9	9	512
4653	Ward 10	10	512
4654	Ward 11	11	512
4655	Ward 12	12	512
4656	Ward 13	13	512
4657	Ward 14	14	512
4658	Ward 1	1	513
4659	Ward 2	2	513
4660	Ward 3	3	513
4661	Ward 4	4	513
4662	Ward 5	5	513
4663	Ward 6	6	513
4664	Ward 7	7	513
4665	Ward 8	8	513
4666	Ward 9	9	513
4667	Ward 10	10	513
4668	Ward 1	1	514
4669	Ward 2	2	514
4670	Ward 3	3	514
4671	Ward 4	4	514
4672	Ward 5	5	514
4673	Ward 6	6	514
4674	Ward 7	7	514
4675	Ward 8	8	514
4676	Ward 1	1	515
4677	Ward 2	2	515
4678	Ward 3	3	515
4679	Ward 4	4	515
4680	Ward 5	5	515
4681	Ward 6	6	515
4682	Ward 7	7	515
4683	Ward 8	8	515
4684	Ward 1	1	516
4685	Ward 2	2	516
4686	Ward 3	3	516
4687	Ward 4	4	516
4688	Ward 5	5	516
4689	Ward 6	6	516
4690	Ward 7	7	516
4691	Ward 8	8	516
4692	Ward 9	9	516
4693	Ward 1	1	517
4694	Ward 2	2	517
4695	Ward 3	3	517
4696	Ward 4	4	517
4697	Ward 5	5	517
4698	Ward 6	6	517
4699	Ward 7	7	517
4700	Ward 8	8	517
4701	Ward 9	9	517
4702	Ward 10	10	517
4703	Ward 11	11	517
4704	Ward 12	12	517
4705	Ward 13	13	517
4706	Ward 14	14	517
4707	Ward 1	1	518
4708	Ward 2	2	518
4709	Ward 3	3	518
4710	Ward 4	4	518
4711	Ward 5	5	518
4712	Ward 6	6	518
4713	Ward 7	7	518
4714	Ward 8	8	518
4715	Ward 9	9	518
4716	Ward 1	1	519
4717	Ward 2	2	519
4718	Ward 3	3	519
4719	Ward 4	4	519
4720	Ward 5	5	519
4721	Ward 6	6	519
4722	Ward 1	1	520
4723	Ward 2	2	520
4724	Ward 3	3	520
4725	Ward 4	4	520
4726	Ward 5	5	520
4727	Ward 6	6	520
4728	Ward 1	1	521
4729	Ward 2	2	521
4730	Ward 3	3	521
4731	Ward 4	4	521
4732	Ward 5	5	521
4733	Ward 6	6	521
4734	Ward 7	7	521
4735	Ward 1	1	522
4736	Ward 2	2	522
4737	Ward 3	3	522
4738	Ward 4	4	522
4739	Ward 5	5	522
4740	Ward 6	6	522
4741	Ward 7	7	522
4742	Ward 8	8	522
4743	Ward 1	1	523
4744	Ward 2	2	523
4745	Ward 3	3	523
4746	Ward 4	4	523
4747	Ward 5	5	523
4748	Ward 6	6	523
4749	Ward 7	7	523
4750	Ward 8	8	523
4751	Ward 1	1	524
4752	Ward 2	2	524
4753	Ward 3	3	524
4754	Ward 4	4	524
4755	Ward 5	5	524
4756	Ward 6	6	524
4757	Ward 7	7	524
4758	Ward 1	1	525
4759	Ward 2	2	525
4760	Ward 3	3	525
4761	Ward 4	4	525
4762	Ward 5	5	525
4763	Ward 6	6	525
4764	Ward 7	7	525
4765	Ward 1	1	526
4766	Ward 2	2	526
4767	Ward 3	3	526
4768	Ward 4	4	526
4769	Ward 5	5	526
4770	Ward 6	6	526
4771	Ward 1	1	527
4772	Ward 2	2	527
4773	Ward 3	3	527
4774	Ward 4	4	527
4775	Ward 5	5	527
4776	Ward 6	6	527
4777	Ward 7	7	527
4778	Ward 8	8	527
4779	Ward 1	1	528
4780	Ward 2	2	528
4781	Ward 3	3	528
4782	Ward 4	4	528
4783	Ward 5	5	528
4784	Ward 6	6	528
4785	Ward 7	7	528
4786	Ward 1	1	529
4787	Ward 2	2	529
4788	Ward 3	3	529
4789	Ward 4	4	529
4790	Ward 5	5	529
4791	Ward 6	6	529
4792	Ward 7	7	529
4793	Ward 8	8	529
4794	Ward 9	9	529
4795	Ward 10	10	529
4796	Ward 11	11	529
4797	Ward 12	12	529
4798	Ward 13	13	529
4799	Ward 14	14	529
4800	Ward 1	1	530
4801	Ward 2	2	530
4802	Ward 3	3	530
4803	Ward 4	4	530
4804	Ward 5	5	530
4805	Ward 6	6	530
4806	Ward 7	7	530
4807	Ward 8	8	530
4808	Ward 9	9	530
4809	Ward 10	10	530
4810	Ward 1	1	531
4811	Ward 2	2	531
4812	Ward 3	3	531
4813	Ward 4	4	531
4814	Ward 5	5	531
4815	Ward 6	6	531
4816	Ward 7	7	531
4817	Ward 8	8	531
4818	Ward 1	1	532
4819	Ward 2	2	532
4820	Ward 3	3	532
4821	Ward 4	4	532
4822	Ward 5	5	532
4823	Ward 6	6	532
4824	Ward 7	7	532
4825	Ward 8	8	532
4826	Ward 1	1	533
4827	Ward 2	2	533
4828	Ward 3	3	533
4829	Ward 4	4	533
4830	Ward 5	5	533
4831	Ward 6	6	533
4832	Ward 7	7	533
4833	Ward 8	8	533
4834	Ward 9	9	533
4835	Ward 1	1	534
4836	Ward 2	2	534
4837	Ward 3	3	534
4838	Ward 4	4	534
4839	Ward 5	5	534
4840	Ward 1	1	535
4841	Ward 2	2	535
4842	Ward 3	3	535
4843	Ward 4	4	535
4844	Ward 5	5	535
4845	Ward 6	6	535
4846	Ward 1	1	536
4847	Ward 2	2	536
4848	Ward 3	3	536
4849	Ward 4	4	536
4850	Ward 5	5	536
4851	Ward 6	6	536
4852	Ward 7	7	536
4853	Ward 1	1	537
4854	Ward 2	2	537
4855	Ward 3	3	537
4856	Ward 4	4	537
4857	Ward 5	5	537
4858	Ward 6	6	537
4859	Ward 7	7	537
4860	Ward 8	8	537
4861	Ward 1	1	538
4862	Ward 2	2	538
4863	Ward 3	3	538
4864	Ward 4	4	538
4865	Ward 5	5	538
4866	Ward 6	6	538
4867	Ward 1	1	539
4868	Ward 2	2	539
4869	Ward 3	3	539
4870	Ward 4	4	539
4871	Ward 5	5	539
4872	Ward 6	6	539
4873	Ward 7	7	539
4874	Ward 8	8	539
4875	Ward 9	9	539
4876	Ward 10	10	539
4877	Ward 11	11	539
4878	Ward 12	12	539
4879	Ward 13	13	539
4880	Ward 14	14	539
4881	Ward 15	15	539
4882	Ward 16	16	539
4883	Ward 17	17	539
4884	Ward 18	18	539
4885	Ward 19	19	539
4886	Ward 1	1	540
4887	Ward 2	2	540
4888	Ward 3	3	540
4889	Ward 4	4	540
4890	Ward 5	5	540
4891	Ward 6	6	540
4892	Ward 7	7	540
4893	Ward 8	8	540
4894	Ward 9	9	540
4895	Ward 10	10	540
4896	Ward 11	11	540
4897	Ward 12	12	540
4898	Ward 13	13	540
4899	Ward 14	14	540
4900	Ward 15	15	540
4901	Ward 16	16	540
4902	Ward 17	17	540
4903	Ward 18	18	540
4904	Ward 19	19	540
4905	Ward 1	1	541
4906	Ward 2	2	541
4907	Ward 3	3	541
4908	Ward 4	4	541
4909	Ward 5	5	541
4910	Ward 6	6	541
4911	Ward 7	7	541
4912	Ward 8	8	541
4913	Ward 9	9	541
4914	Ward 1	1	542
4915	Ward 2	2	542
4916	Ward 3	3	542
4917	Ward 4	4	542
4918	Ward 5	5	542
4919	Ward 6	6	542
4920	Ward 7	7	542
4921	Ward 8	8	542
4922	Ward 1	1	543
4923	Ward 2	2	543
4924	Ward 3	3	543
4925	Ward 4	4	543
4926	Ward 5	5	543
4927	Ward 6	6	543
4928	Ward 7	7	543
4929	Ward 1	1	544
4930	Ward 2	2	544
4931	Ward 3	3	544
4932	Ward 4	4	544
4933	Ward 5	5	544
4934	Ward 6	6	544
4935	Ward 7	7	544
4936	Ward 1	1	545
4937	Ward 2	2	545
4938	Ward 3	3	545
4939	Ward 4	4	545
4940	Ward 5	5	545
4941	Ward 6	6	545
4942	Ward 7	7	545
4943	Ward 8	8	545
4944	Ward 9	9	545
4945	Ward 1	1	546
4946	Ward 2	2	546
4947	Ward 3	3	546
4948	Ward 4	4	546
4949	Ward 5	5	546
4950	Ward 6	6	546
4951	Ward 7	7	546
4952	Ward 8	8	546
4953	Ward 1	1	547
4954	Ward 2	2	547
4955	Ward 3	3	547
4956	Ward 4	4	547
4957	Ward 5	5	547
4958	Ward 6	6	547
4959	Ward 7	7	547
4960	Ward 1	1	548
4961	Ward 2	2	548
4962	Ward 3	3	548
4963	Ward 4	4	548
4964	Ward 5	5	548
4965	Ward 6	6	548
4966	Ward 7	7	548
4967	Ward 1	1	549
4968	Ward 2	2	549
4969	Ward 3	3	549
4970	Ward 4	4	549
4971	Ward 5	5	549
4972	Ward 6	6	549
4973	Ward 7	7	549
4974	Ward 8	8	549
4975	Ward 9	9	549
4976	Ward 1	1	550
4977	Ward 2	2	550
4978	Ward 3	3	550
4979	Ward 4	4	550
4980	Ward 5	5	550
4981	Ward 6	6	550
4982	Ward 7	7	550
4983	Ward 8	8	550
4984	Ward 9	9	550
4985	Ward 10	10	550
4986	Ward 1	1	551
4987	Ward 2	2	551
4988	Ward 3	3	551
4989	Ward 4	4	551
4990	Ward 5	5	551
4991	Ward 1	1	552
4992	Ward 2	2	552
4993	Ward 3	3	552
4994	Ward 4	4	552
4995	Ward 5	5	552
4996	Ward 6	6	552
4997	Ward 1	1	553
4998	Ward 2	2	553
4999	Ward 3	3	553
5000	Ward 4	4	553
5001	Ward 5	5	553
5002	Ward 6	6	553
5003	Ward 1	1	554
5004	Ward 2	2	554
5005	Ward 3	3	554
5006	Ward 4	4	554
5007	Ward 5	5	554
5008	Ward 1	1	555
5009	Ward 2	2	555
5010	Ward 3	3	555
5011	Ward 4	4	555
5012	Ward 5	5	555
5013	Ward 6	6	555
5014	Ward 7	7	555
5015	Ward 8	8	555
5016	Ward 1	1	556
5017	Ward 2	2	556
5018	Ward 3	3	556
5019	Ward 4	4	556
5020	Ward 5	5	556
5021	Ward 6	6	556
5022	Ward 7	7	556
5023	Ward 8	8	556
5024	Ward 1	1	557
5025	Ward 2	2	557
5026	Ward 3	3	557
5027	Ward 4	4	557
5028	Ward 5	5	557
5029	Ward 6	6	557
5030	Ward 7	7	557
5031	Ward 1	1	558
5032	Ward 2	2	558
5033	Ward 3	3	558
5034	Ward 4	4	558
5035	Ward 5	5	558
5036	Ward 6	6	558
5037	Ward 7	7	558
5038	Ward 8	8	558
5039	Ward 9	9	558
5040	Ward 10	10	558
5041	Ward 1	1	559
5042	Ward 2	2	559
5043	Ward 3	3	559
5044	Ward 4	4	559
5045	Ward 5	5	559
5046	Ward 6	6	559
5047	Ward 7	7	559
5048	Ward 8	8	559
5049	Ward 9	9	559
5050	Ward 1	1	560
5051	Ward 2	2	560
5052	Ward 3	3	560
5053	Ward 4	4	560
5054	Ward 5	5	560
5055	Ward 6	6	560
5056	Ward 7	7	560
5057	Ward 1	1	561
5058	Ward 2	2	561
5059	Ward 3	3	561
5060	Ward 4	4	561
5061	Ward 5	5	561
5062	Ward 6	6	561
5063	Ward 7	7	561
5064	Ward 8	8	561
5065	Ward 1	1	562
5066	Ward 2	2	562
5067	Ward 3	3	562
5068	Ward 4	4	562
5069	Ward 5	5	562
5070	Ward 6	6	562
5071	Ward 7	7	562
5072	Ward 1	1	563
5073	Ward 2	2	563
5074	Ward 3	3	563
5075	Ward 4	4	563
5076	Ward 5	5	563
5077	Ward 6	6	563
5078	Ward 7	7	563
5079	Ward 1	1	564
5080	Ward 2	2	564
5081	Ward 3	3	564
5082	Ward 4	4	564
5083	Ward 5	5	564
5084	Ward 1	1	565
5085	Ward 2	2	565
5086	Ward 3	3	565
5087	Ward 4	4	565
5088	Ward 5	5	565
5089	Ward 6	6	565
5090	Ward 1	1	566
5091	Ward 2	2	566
5092	Ward 3	3	566
5093	Ward 4	4	566
5094	Ward 5	5	566
5095	Ward 6	6	566
5096	Ward 7	7	566
5097	Ward 1	1	567
5098	Ward 2	2	567
5099	Ward 3	3	567
5100	Ward 4	4	567
5101	Ward 5	5	567
5102	Ward 6	6	567
5103	Ward 1	1	568
5104	Ward 2	2	568
5105	Ward 3	3	568
5106	Ward 4	4	568
5107	Ward 5	5	568
5108	Ward 6	6	568
5109	Ward 7	7	568
5110	Ward 8	8	568
5111	Ward 9	9	568
5112	Ward 10	10	568
5113	Ward 11	11	568
5114	Ward 12	12	568
5115	Ward 13	13	568
5116	Ward 14	14	568
5117	Ward 1	1	569
5118	Ward 2	2	569
5119	Ward 3	3	569
5120	Ward 4	4	569
5121	Ward 5	5	569
5122	Ward 6	6	569
5123	Ward 7	7	569
5124	Ward 8	8	569
5125	Ward 9	9	569
5126	Ward 1	1	570
5127	Ward 2	2	570
5128	Ward 3	3	570
5129	Ward 4	4	570
5130	Ward 5	5	570
5131	Ward 6	6	570
5132	Ward 7	7	570
5133	Ward 8	8	570
5134	Ward 1	1	571
5135	Ward 2	2	571
5136	Ward 3	3	571
5137	Ward 4	4	571
5138	Ward 5	5	571
5139	Ward 6	6	571
5140	Ward 7	7	571
5141	Ward 8	8	571
5142	Ward 9	9	571
5143	Ward 10	10	571
5144	Ward 11	11	571
5145	Ward 12	12	571
5146	Ward 13	13	571
5147	Ward 14	14	571
5148	Ward 15	15	571
5149	Ward 16	16	571
5150	Ward 17	17	571
5151	Ward 18	18	571
5152	Ward 19	19	571
5153	Ward 20	20	571
5154	Ward 21	21	571
5155	Ward 22	22	571
5156	Ward 23	23	571
5157	Ward 1	1	572
5158	Ward 2	2	572
5159	Ward 3	3	572
5160	Ward 4	4	572
5161	Ward 5	5	572
5162	Ward 6	6	572
5163	Ward 7	7	572
5164	Ward 8	8	572
5165	Ward 9	9	572
5166	Ward 10	10	572
5167	Ward 11	11	572
5168	Ward 12	12	572
5169	Ward 13	13	572
5170	Ward 14	14	572
5171	Ward 15	15	572
5172	Ward 1	1	573
5173	Ward 2	2	573
5174	Ward 3	3	573
5175	Ward 4	4	573
5176	Ward 5	5	573
5177	Ward 6	6	573
5178	Ward 7	7	573
5179	Ward 8	8	573
5180	Ward 9	9	573
5181	Ward 1	1	574
5182	Ward 2	2	574
5183	Ward 3	3	574
5184	Ward 4	4	574
5185	Ward 5	5	574
5186	Ward 6	6	574
5187	Ward 1	1	575
5188	Ward 2	2	575
5189	Ward 3	3	575
5190	Ward 4	4	575
5191	Ward 5	5	575
5192	Ward 6	6	575
5193	Ward 1	1	576
5194	Ward 2	2	576
5195	Ward 3	3	576
5196	Ward 4	4	576
5197	Ward 5	5	576
5198	Ward 6	6	576
5199	Ward 1	1	577
5200	Ward 2	2	577
5201	Ward 3	3	577
5202	Ward 4	4	577
5203	Ward 5	5	577
5204	Ward 6	6	577
5205	Ward 7	7	577
5206	Ward 8	8	577
5207	Ward 1	1	578
5208	Ward 2	2	578
5209	Ward 3	3	578
5210	Ward 4	4	578
5211	Ward 5	5	578
5212	Ward 6	6	578
5213	Ward 7	7	578
5214	Ward 8	8	578
5215	Ward 1	1	579
5216	Ward 2	2	579
5217	Ward 3	3	579
5218	Ward 4	4	579
5219	Ward 5	5	579
5220	Ward 6	6	579
5221	Ward 7	7	579
5222	Ward 8	8	579
5223	Ward 9	9	579
5224	Ward 10	10	579
5225	Ward 11	11	579
5226	Ward 12	12	579
5227	Ward 1	1	580
5228	Ward 2	2	580
5229	Ward 3	3	580
5230	Ward 4	4	580
5231	Ward 5	5	580
5232	Ward 6	6	580
5233	Ward 7	7	580
5234	Ward 8	8	580
5235	Ward 9	9	580
5236	Ward 10	10	580
5237	Ward 1	1	581
5238	Ward 2	2	581
5239	Ward 3	3	581
5240	Ward 4	4	581
5241	Ward 5	5	581
5242	Ward 6	6	581
5243	Ward 7	7	581
5244	Ward 8	8	581
5245	Ward 9	9	581
5246	Ward 1	1	582
5247	Ward 2	2	582
5248	Ward 3	3	582
5249	Ward 4	4	582
5250	Ward 5	5	582
5251	Ward 6	6	582
5252	Ward 7	7	582
5253	Ward 8	8	582
5254	Ward 9	9	582
5255	Ward 1	1	583
5256	Ward 2	2	583
5257	Ward 3	3	583
5258	Ward 4	4	583
5259	Ward 5	5	583
5260	Ward 6	6	583
5261	Ward 7	7	583
5262	Ward 8	8	583
5263	Ward 9	9	583
5264	Ward 1	1	584
5265	Ward 2	2	584
5266	Ward 3	3	584
5267	Ward 4	4	584
5268	Ward 5	5	584
5269	Ward 6	6	584
5270	Ward 7	7	584
5271	Ward 8	8	584
5272	Ward 9	9	584
5273	Ward 10	10	584
5274	Ward 11	11	584
5275	Ward 1	1	585
5276	Ward 2	2	585
5277	Ward 3	3	585
5278	Ward 4	4	585
5279	Ward 5	5	585
5280	Ward 6	6	585
5281	Ward 7	7	585
5282	Ward 8	8	585
5283	Ward 9	9	585
5284	Ward 1	1	586
5285	Ward 2	2	586
5286	Ward 3	3	586
5287	Ward 4	4	586
5288	Ward 5	5	586
5289	Ward 6	6	586
5290	Ward 1	1	587
5291	Ward 2	2	587
5292	Ward 3	3	587
5293	Ward 4	4	587
5294	Ward 5	5	587
5295	Ward 6	6	587
5296	Ward 7	7	587
5297	Ward 8	8	587
5298	Ward 9	9	587
5299	Ward 10	10	587
5300	Ward 11	11	587
5301	Ward 12	12	587
5302	Ward 13	13	587
5303	Ward 14	14	587
5304	Ward 1	1	588
5305	Ward 2	2	588
5306	Ward 3	3	588
5307	Ward 4	4	588
5308	Ward 5	5	588
5309	Ward 6	6	588
5310	Ward 7	7	588
5311	Ward 8	8	588
5312	Ward 9	9	588
5313	Ward 10	10	588
5314	Ward 11	11	588
5315	Ward 12	12	588
5316	Ward 13	13	588
5317	Ward 14	14	588
5318	Ward 1	1	589
5319	Ward 2	2	589
5320	Ward 3	3	589
5321	Ward 4	4	589
5322	Ward 5	5	589
5323	Ward 6	6	589
5324	Ward 7	7	589
5325	Ward 8	8	589
5326	Ward 9	9	589
5327	Ward 10	10	589
5328	Ward 11	11	589
5329	Ward 12	12	589
5330	Ward 13	13	589
5331	Ward 14	14	589
5332	Ward 1	1	590
5333	Ward 2	2	590
5334	Ward 3	3	590
5335	Ward 4	4	590
5336	Ward 5	5	590
5337	Ward 6	6	590
5338	Ward 7	7	590
5339	Ward 8	8	590
5340	Ward 9	9	590
5341	Ward 10	10	590
5342	Ward 11	11	590
5343	Ward 1	1	591
5344	Ward 2	2	591
5345	Ward 3	3	591
5346	Ward 4	4	591
5347	Ward 5	5	591
5348	Ward 6	6	591
5349	Ward 7	7	591
5350	Ward 8	8	591
5351	Ward 9	9	591
5352	Ward 10	10	591
5353	Ward 1	1	592
5354	Ward 2	2	592
5355	Ward 3	3	592
5356	Ward 4	4	592
5357	Ward 5	5	592
5358	Ward 6	6	592
5359	Ward 7	7	592
5360	Ward 8	8	592
5361	Ward 9	9	592
5362	Ward 10	10	592
5363	Ward 1	1	593
5364	Ward 2	2	593
5365	Ward 3	3	593
5366	Ward 4	4	593
5367	Ward 5	5	593
5368	Ward 6	6	593
5369	Ward 7	7	593
5370	Ward 1	1	594
5371	Ward 2	2	594
5372	Ward 3	3	594
5373	Ward 4	4	594
5374	Ward 5	5	594
5375	Ward 6	6	594
5376	Ward 7	7	594
5377	Ward 1	1	595
5378	Ward 2	2	595
5379	Ward 3	3	595
5380	Ward 4	4	595
5381	Ward 5	5	595
5382	Ward 6	6	595
5383	Ward 7	7	595
5384	Ward 1	1	596
5385	Ward 2	2	596
5386	Ward 3	3	596
5387	Ward 4	4	596
5388	Ward 5	5	596
5389	Ward 6	6	596
5390	Ward 1	1	597
5391	Ward 2	2	597
5392	Ward 3	3	597
5393	Ward 4	4	597
5394	Ward 5	5	597
5395	Ward 6	6	597
5396	Ward 1	1	598
5397	Ward 2	2	598
5398	Ward 3	3	598
5399	Ward 4	4	598
5400	Ward 5	5	598
5401	Ward 6	6	598
5402	Ward 1	1	599
5403	Ward 2	2	599
5404	Ward 3	3	599
5405	Ward 4	4	599
5406	Ward 5	5	599
5407	Ward 1	1	600
5408	Ward 2	2	600
5409	Ward 3	3	600
5410	Ward 4	4	600
5411	Ward 5	5	600
5412	Ward 6	6	600
5413	Ward 7	7	600
5414	Ward 8	8	600
5415	Ward 9	9	600
5416	Ward 10	10	600
5417	Ward 11	11	600
5418	Ward 12	12	600
5419	Ward 1	1	601
5420	Ward 2	2	601
5421	Ward 3	3	601
5422	Ward 4	4	601
5423	Ward 5	5	601
5424	Ward 6	6	601
5425	Ward 7	7	601
5426	Ward 8	8	601
5427	Ward 9	9	601
5428	Ward 10	10	601
5429	Ward 11	11	601
5430	Ward 12	12	601
5431	Ward 13	13	601
5432	Ward 14	14	601
5433	Ward 15	15	601
5434	Ward 1	1	602
5435	Ward 2	2	602
5436	Ward 3	3	602
5437	Ward 4	4	602
5438	Ward 5	5	602
5439	Ward 6	6	602
5440	Ward 7	7	602
5441	Ward 8	8	602
5442	Ward 9	9	602
5443	Ward 10	10	602
5444	Ward 11	11	602
5445	Ward 12	12	602
5446	Ward 1	1	603
5447	Ward 2	2	603
5448	Ward 3	3	603
5449	Ward 4	4	603
5450	Ward 5	5	603
5451	Ward 6	6	603
5452	Ward 7	7	603
5453	Ward 8	8	603
5454	Ward 9	9	603
5455	Ward 1	1	604
5456	Ward 2	2	604
5457	Ward 3	3	604
5458	Ward 4	4	604
5459	Ward 5	5	604
5460	Ward 6	6	604
5461	Ward 7	7	604
5462	Ward 1	1	605
5463	Ward 2	2	605
5464	Ward 3	3	605
5465	Ward 4	4	605
5466	Ward 5	5	605
5467	Ward 6	6	605
5468	Ward 7	7	605
5469	Ward 8	8	605
5470	Ward 9	9	605
5471	Ward 1	1	606
5472	Ward 2	2	606
5473	Ward 3	3	606
5474	Ward 4	4	606
5475	Ward 5	5	606
5476	Ward 6	6	606
5477	Ward 1	1	607
5478	Ward 2	2	607
5479	Ward 3	3	607
5480	Ward 4	4	607
5481	Ward 5	5	607
5482	Ward 6	6	607
5483	Ward 1	1	608
5484	Ward 2	2	608
5485	Ward 3	3	608
5486	Ward 4	4	608
5487	Ward 5	5	608
5488	Ward 6	6	608
5489	Ward 1	1	609
5490	Ward 2	2	609
5491	Ward 3	3	609
5492	Ward 4	4	609
5493	Ward 5	5	609
5494	Ward 6	6	609
5495	Ward 7	7	609
5496	Ward 8	8	609
5497	Ward 9	9	609
5498	Ward 10	10	609
5499	Ward 11	11	609
5500	Ward 1	1	610
5501	Ward 2	2	610
5502	Ward 3	3	610
5503	Ward 4	4	610
5504	Ward 5	5	610
5505	Ward 6	6	610
5506	Ward 7	7	610
5507	Ward 8	8	610
5508	Ward 9	9	610
5509	Ward 10	10	610
5510	Ward 11	11	610
5511	Ward 1	1	611
5512	Ward 2	2	611
5513	Ward 3	3	611
5514	Ward 4	4	611
5515	Ward 5	5	611
5516	Ward 6	6	611
5517	Ward 7	7	611
5518	Ward 8	8	611
5519	Ward 1	1	612
5520	Ward 2	2	612
5521	Ward 3	3	612
5522	Ward 4	4	612
5523	Ward 5	5	612
5524	Ward 6	6	612
5525	Ward 7	7	612
5526	Ward 8	8	612
5527	Ward 1	1	613
5528	Ward 2	2	613
5529	Ward 3	3	613
5530	Ward 4	4	613
5531	Ward 5	5	613
5532	Ward 6	6	613
5533	Ward 1	1	614
5534	Ward 2	2	614
5535	Ward 3	3	614
5536	Ward 4	4	614
5537	Ward 5	5	614
5538	Ward 1	1	615
5539	Ward 2	2	615
5540	Ward 3	3	615
5541	Ward 4	4	615
5542	Ward 5	5	615
5543	Ward 1	1	616
5544	Ward 2	2	616
5545	Ward 3	3	616
5546	Ward 4	4	616
5547	Ward 5	5	616
5548	Ward 6	6	616
5549	Ward 1	1	617
5550	Ward 2	2	617
5551	Ward 3	3	617
5552	Ward 4	4	617
5553	Ward 5	5	617
5554	Ward 6	6	617
5555	Ward 1	1	618
5556	Ward 2	2	618
5557	Ward 3	3	618
5558	Ward 4	4	618
5559	Ward 5	5	618
5560	Ward 6	6	618
5561	Ward 7	7	618
5562	Ward 8	8	618
5563	Ward 1	1	619
5564	Ward 2	2	619
5565	Ward 3	3	619
5566	Ward 4	4	619
5567	Ward 5	5	619
5568	Ward 6	6	619
5569	Ward 7	7	619
5570	Ward 1	1	620
5571	Ward 2	2	620
5572	Ward 3	3	620
5573	Ward 4	4	620
5574	Ward 5	5	620
5575	Ward 6	6	620
5576	Ward 7	7	620
5577	Ward 8	8	620
5578	Ward 9	9	620
5579	Ward 1	1	621
5580	Ward 2	2	621
5581	Ward 3	3	621
5582	Ward 4	4	621
5583	Ward 5	5	621
5584	Ward 6	6	621
5585	Ward 7	7	621
5586	Ward 8	8	621
5587	Ward 1	1	622
5588	Ward 2	2	622
5589	Ward 3	3	622
5590	Ward 4	4	622
5591	Ward 5	5	622
5592	Ward 6	6	622
5593	Ward 1	1	623
5594	Ward 2	2	623
5595	Ward 3	3	623
5596	Ward 4	4	623
5597	Ward 5	5	623
5598	Ward 6	6	623
5599	Ward 7	7	623
5600	Ward 1	1	624
5601	Ward 2	2	624
5602	Ward 3	3	624
5603	Ward 4	4	624
5604	Ward 5	5	624
5605	Ward 1	1	625
5606	Ward 2	2	625
5607	Ward 3	3	625
5608	Ward 4	4	625
5609	Ward 5	5	625
5610	Ward 6	6	625
5611	Ward 7	7	625
5612	Ward 8	8	625
5613	Ward 9	9	625
5614	Ward 10	10	625
5615	Ward 1	1	626
5616	Ward 2	2	626
5617	Ward 3	3	626
5618	Ward 4	4	626
5619	Ward 5	5	626
5620	Ward 6	6	626
5621	Ward 7	7	626
5622	Ward 8	8	626
5623	Ward 9	9	626
5624	Ward 10	10	626
5625	Ward 11	11	626
5626	Ward 1	1	627
5627	Ward 2	2	627
5628	Ward 3	3	627
5629	Ward 4	4	627
5630	Ward 5	5	627
5631	Ward 6	6	627
5632	Ward 7	7	627
5633	Ward 8	8	627
5634	Ward 9	9	627
5635	Ward 1	1	628
5636	Ward 2	2	628
5637	Ward 3	3	628
5638	Ward 4	4	628
5639	Ward 5	5	628
5640	Ward 6	6	628
5641	Ward 7	7	628
5642	Ward 8	8	628
5643	Ward 9	9	628
5644	Ward 10	10	628
5645	Ward 11	11	628
5646	Ward 1	1	629
5647	Ward 2	2	629
5648	Ward 3	3	629
5649	Ward 4	4	629
5650	Ward 5	5	629
5651	Ward 6	6	629
5652	Ward 7	7	629
5653	Ward 8	8	629
5654	Ward 9	9	629
5655	Ward 1	1	630
5656	Ward 2	2	630
5657	Ward 3	3	630
5658	Ward 4	4	630
5659	Ward 5	5	630
5660	Ward 6	6	630
5661	Ward 7	7	630
5662	Ward 8	8	630
5663	Ward 9	9	630
5664	Ward 1	1	631
5665	Ward 2	2	631
5666	Ward 3	3	631
5667	Ward 4	4	631
5668	Ward 5	5	631
5669	Ward 6	6	631
5670	Ward 7	7	631
5671	Ward 8	8	631
5672	Ward 1	1	632
5673	Ward 2	2	632
5674	Ward 3	3	632
5675	Ward 4	4	632
5676	Ward 5	5	632
5677	Ward 6	6	632
5678	Ward 7	7	632
5679	Ward 8	8	632
5680	Ward 9	9	632
5681	Ward 1	1	633
5682	Ward 2	2	633
5683	Ward 3	3	633
5684	Ward 4	4	633
5685	Ward 5	5	633
5686	Ward 6	6	633
5687	Ward 7	7	633
5688	Ward 8	8	633
5689	Ward 9	9	633
5690	Ward 1	1	634
5691	Ward 2	2	634
5692	Ward 3	3	634
5693	Ward 4	4	634
5694	Ward 5	5	634
5695	Ward 6	6	634
5696	Ward 7	7	634
5697	Ward 1	1	635
5698	Ward 2	2	635
5699	Ward 3	3	635
5700	Ward 4	4	635
5701	Ward 5	5	635
5702	Ward 6	6	635
5703	Ward 7	7	635
5704	Ward 8	8	635
5705	Ward 9	9	635
5706	Ward 10	10	635
5707	Ward 11	11	635
5708	Ward 1	1	636
5709	Ward 2	2	636
5710	Ward 3	3	636
5711	Ward 4	4	636
5712	Ward 5	5	636
5713	Ward 6	6	636
5714	Ward 7	7	636
5715	Ward 8	8	636
5716	Ward 9	9	636
5717	Ward 10	10	636
5718	Ward 11	11	636
5719	Ward 1	1	637
5720	Ward 2	2	637
5721	Ward 3	3	637
5722	Ward 4	4	637
5723	Ward 5	5	637
5724	Ward 6	6	637
5725	Ward 7	7	637
5726	Ward 8	8	637
5727	Ward 9	9	637
5728	Ward 1	1	638
5729	Ward 2	2	638
5730	Ward 3	3	638
5731	Ward 4	4	638
5732	Ward 5	5	638
5733	Ward 6	6	638
5734	Ward 7	7	638
5735	Ward 8	8	638
5736	Ward 9	9	638
5737	Ward 10	10	638
5738	Ward 11	11	638
5739	Ward 12	12	638
5740	Ward 13	13	638
5741	Ward 14	14	638
5742	Ward 1	1	639
5743	Ward 2	2	639
5744	Ward 3	3	639
5745	Ward 4	4	639
5746	Ward 5	5	639
5747	Ward 6	6	639
5748	Ward 7	7	639
5749	Ward 8	8	639
5750	Ward 9	9	639
5751	Ward 1	1	640
5752	Ward 2	2	640
5753	Ward 3	3	640
5754	Ward 4	4	640
5755	Ward 5	5	640
5756	Ward 6	6	640
5757	Ward 7	7	640
5758	Ward 8	8	640
5759	Ward 9	9	640
5760	Ward 10	10	640
5761	Ward 1	1	641
5762	Ward 2	2	641
5763	Ward 3	3	641
5764	Ward 4	4	641
5765	Ward 5	5	641
5766	Ward 6	6	641
5767	Ward 7	7	641
5768	Ward 8	8	641
5769	Ward 9	9	641
5770	Ward 10	10	641
5771	Ward 1	1	642
5772	Ward 2	2	642
5773	Ward 3	3	642
5774	Ward 4	4	642
5775	Ward 5	5	642
5776	Ward 6	6	642
5777	Ward 1	1	643
5778	Ward 2	2	643
5779	Ward 3	3	643
5780	Ward 4	4	643
5781	Ward 5	5	643
5782	Ward 6	6	643
5783	Ward 7	7	643
5784	Ward 8	8	643
5785	Ward 9	9	643
5786	Ward 10	10	643
5787	Ward 11	11	643
5788	Ward 12	12	643
5789	Ward 13	13	643
5790	Ward 14	14	643
5791	Ward 1	1	644
5792	Ward 2	2	644
5793	Ward 3	3	644
5794	Ward 4	4	644
5795	Ward 5	5	644
5796	Ward 6	6	644
5797	Ward 7	7	644
5798	Ward 8	8	644
5799	Ward 9	9	644
5800	Ward 10	10	644
5801	Ward 11	11	644
5802	Ward 12	12	644
5803	Ward 13	13	644
5804	Ward 14	14	644
5805	Ward 15	15	644
5806	Ward 16	16	644
5807	Ward 1	1	645
5808	Ward 2	2	645
5809	Ward 3	3	645
5810	Ward 4	4	645
5811	Ward 5	5	645
5812	Ward 6	6	645
5813	Ward 7	7	645
5814	Ward 8	8	645
5815	Ward 9	9	645
5816	Ward 10	10	645
5817	Ward 11	11	645
5818	Ward 12	12	645
5819	Ward 13	13	645
5820	Ward 1	1	646
5821	Ward 2	2	646
5822	Ward 3	3	646
5823	Ward 4	4	646
5824	Ward 5	5	646
5825	Ward 6	6	646
5826	Ward 7	7	646
5827	Ward 8	8	646
5828	Ward 9	9	646
5829	Ward 10	10	646
5830	Ward 11	11	646
5831	Ward 1	1	647
5832	Ward 2	2	647
5833	Ward 3	3	647
5834	Ward 4	4	647
5835	Ward 5	5	647
5836	Ward 6	6	647
5837	Ward 7	7	647
5838	Ward 8	8	647
5839	Ward 9	9	647
5840	Ward 10	10	647
5841	Ward 1	1	648
5842	Ward 2	2	648
5843	Ward 3	3	648
5844	Ward 4	4	648
5845	Ward 5	5	648
5846	Ward 6	6	648
5847	Ward 7	7	648
5848	Ward 8	8	648
5849	Ward 9	9	648
5850	Ward 10	10	648
5851	Ward 11	11	648
5852	Ward 12	12	648
5853	Ward 13	13	648
5854	Ward 1	1	649
5855	Ward 2	2	649
5856	Ward 3	3	649
5857	Ward 4	4	649
5858	Ward 5	5	649
5859	Ward 6	6	649
5860	Ward 7	7	649
5861	Ward 8	8	649
5862	Ward 1	1	650
5863	Ward 2	2	650
5864	Ward 3	3	650
5865	Ward 4	4	650
5866	Ward 5	5	650
5867	Ward 6	6	650
5868	Ward 7	7	650
5869	Ward 1	1	651
5870	Ward 2	2	651
5871	Ward 3	3	651
5872	Ward 4	4	651
5873	Ward 5	5	651
5874	Ward 6	6	651
5875	Ward 7	7	651
5876	Ward 8	8	651
5877	Ward 1	1	652
5878	Ward 2	2	652
5879	Ward 3	3	652
5880	Ward 4	4	652
5881	Ward 5	5	652
5882	Ward 6	6	652
5883	Ward 1	1	653
5884	Ward 2	2	653
5885	Ward 3	3	653
5886	Ward 4	4	653
5887	Ward 5	5	653
5888	Ward 6	6	653
5889	Ward 1	1	654
5890	Ward 2	2	654
5891	Ward 3	3	654
5892	Ward 4	4	654
5893	Ward 5	5	654
5894	Ward 6	6	654
5895	Ward 7	7	654
5896	Ward 1	1	655
5897	Ward 2	2	655
5898	Ward 3	3	655
5899	Ward 4	4	655
5900	Ward 5	5	655
5901	Ward 6	6	655
5902	Ward 1	1	656
5903	Ward 2	2	656
5904	Ward 3	3	656
5905	Ward 4	4	656
5906	Ward 5	5	656
5907	Ward 6	6	656
5908	Ward 7	7	656
5909	Ward 8	8	656
5910	Ward 9	9	656
5911	Ward 1	1	657
5912	Ward 2	2	657
5913	Ward 3	3	657
5914	Ward 4	4	657
5915	Ward 5	5	657
5916	Ward 6	6	657
5917	Ward 7	7	657
5918	Ward 8	8	657
5919	Ward 9	9	657
5920	Ward 10	10	657
5921	Ward 11	11	657
5922	Ward 1	1	658
5923	Ward 2	2	658
5924	Ward 3	3	658
5925	Ward 4	4	658
5926	Ward 5	5	658
5927	Ward 6	6	658
5928	Ward 7	7	658
5929	Ward 8	8	658
5930	Ward 9	9	658
5931	Ward 1	1	659
5932	Ward 2	2	659
5933	Ward 3	3	659
5934	Ward 4	4	659
5935	Ward 5	5	659
5936	Ward 6	6	659
5937	Ward 7	7	659
5938	Ward 8	8	659
5939	Ward 9	9	659
5940	Ward 10	10	659
5941	Ward 11	11	659
5942	Ward 12	12	659
5943	Ward 13	13	659
5944	Ward 1	1	660
5945	Ward 2	2	660
5946	Ward 3	3	660
5947	Ward 4	4	660
5948	Ward 5	5	660
5949	Ward 6	6	660
5950	Ward 7	7	660
5951	Ward 8	8	660
5952	Ward 9	9	660
5953	Ward 10	10	660
5954	Ward 11	11	660
5955	Ward 12	12	660
5956	Ward 13	13	660
5957	Ward 1	1	661
5958	Ward 2	2	661
5959	Ward 3	3	661
5960	Ward 4	4	661
5961	Ward 5	5	661
5962	Ward 6	6	661
5963	Ward 7	7	661
5964	Ward 8	8	661
5965	Ward 9	9	661
5966	Ward 10	10	661
5967	Ward 11	11	661
5968	Ward 12	12	661
5969	Ward 13	13	661
5970	Ward 1	1	662
5971	Ward 2	2	662
5972	Ward 3	3	662
5973	Ward 4	4	662
5974	Ward 5	5	662
5975	Ward 6	6	662
5976	Ward 7	7	662
5977	Ward 8	8	662
5978	Ward 9	9	662
5979	Ward 10	10	662
5980	Ward 11	11	662
5981	Ward 1	1	663
5982	Ward 2	2	663
5983	Ward 3	3	663
5984	Ward 4	4	663
5985	Ward 5	5	663
5986	Ward 6	6	663
5987	Ward 7	7	663
5988	Ward 8	8	663
5989	Ward 9	9	663
5990	Ward 1	1	664
5991	Ward 2	2	664
5992	Ward 3	3	664
5993	Ward 4	4	664
5994	Ward 5	5	664
5995	Ward 6	6	664
5996	Ward 7	7	664
5997	Ward 8	8	664
5998	Ward 9	9	664
5999	Ward 1	1	665
6000	Ward 2	2	665
6001	Ward 3	3	665
6002	Ward 4	4	665
6003	Ward 5	5	665
6004	Ward 6	6	665
6005	Ward 7	7	665
6006	Ward 8	8	665
6007	Ward 9	9	665
6008	Ward 1	1	666
6009	Ward 2	2	666
6010	Ward 3	3	666
6011	Ward 4	4	666
6012	Ward 5	5	666
6013	Ward 6	6	666
6014	Ward 7	7	666
6015	Ward 8	8	666
6016	Ward 9	9	666
6017	Ward 1	1	667
6018	Ward 2	2	667
6019	Ward 3	3	667
6020	Ward 4	4	667
6021	Ward 5	5	667
6022	Ward 6	6	667
6023	Ward 7	7	667
6024	Ward 8	8	667
6025	Ward 9	9	667
6026	Ward 1	1	668
6027	Ward 2	2	668
6028	Ward 3	3	668
6029	Ward 4	4	668
6030	Ward 5	5	668
6031	Ward 6	6	668
6032	Ward 1	1	669
6033	Ward 2	2	669
6034	Ward 3	3	669
6035	Ward 4	4	669
6036	Ward 5	5	669
6037	Ward 6	6	669
6038	Ward 7	7	669
6039	Ward 8	8	669
6040	Ward 1	1	670
6041	Ward 2	2	670
6042	Ward 3	3	670
6043	Ward 4	4	670
6044	Ward 5	5	670
6045	Ward 6	6	670
6046	Ward 1	1	671
6047	Ward 2	2	671
6048	Ward 3	3	671
6049	Ward 4	4	671
6050	Ward 5	5	671
6051	Ward 6	6	671
6052	Ward 1	1	672
6053	Ward 2	2	672
6054	Ward 3	3	672
6055	Ward 4	4	672
6056	Ward 5	5	672
6057	Ward 1	1	673
6058	Ward 2	2	673
6059	Ward 3	3	673
6060	Ward 4	4	673
6061	Ward 5	5	673
6062	Ward 6	6	673
6063	Ward 1	1	674
6064	Ward 2	2	674
6065	Ward 3	3	674
6066	Ward 4	4	674
6067	Ward 5	5	674
6068	Ward 6	6	674
6069	Ward 1	1	675
6070	Ward 2	2	675
6071	Ward 3	3	675
6072	Ward 4	4	675
6073	Ward 5	5	675
6074	Ward 6	6	675
6075	Ward 7	7	675
6076	Ward 8	8	675
6077	Ward 9	9	675
6078	Ward 10	10	675
6079	Ward 11	11	675
6080	Ward 1	1	676
6081	Ward 2	2	676
6082	Ward 3	3	676
6083	Ward 4	4	676
6084	Ward 5	5	676
6085	Ward 6	6	676
6086	Ward 7	7	676
6087	Ward 8	8	676
6088	Ward 9	9	676
6089	Ward 10	10	676
6090	Ward 11	11	676
6091	Ward 1	1	677
6092	Ward 2	2	677
6093	Ward 3	3	677
6094	Ward 4	4	677
6095	Ward 5	5	677
6096	Ward 6	6	677
6097	Ward 7	7	677
6098	Ward 8	8	677
6099	Ward 9	9	677
6100	Ward 1	1	678
6101	Ward 2	2	678
6102	Ward 3	3	678
6103	Ward 4	4	678
6104	Ward 5	5	678
6105	Ward 6	6	678
6106	Ward 7	7	678
6107	Ward 8	8	678
6108	Ward 9	9	678
6109	Ward 1	1	679
6110	Ward 2	2	679
6111	Ward 3	3	679
6112	Ward 4	4	679
6113	Ward 5	5	679
6114	Ward 6	6	679
6115	Ward 7	7	679
6116	Ward 8	8	679
6117	Ward 9	9	679
6118	Ward 1	1	680
6119	Ward 2	2	680
6120	Ward 3	3	680
6121	Ward 4	4	680
6122	Ward 5	5	680
6123	Ward 6	6	680
6124	Ward 7	7	680
6125	Ward 1	1	681
6126	Ward 2	2	681
6127	Ward 3	3	681
6128	Ward 4	4	681
6129	Ward 5	5	681
6130	Ward 6	6	681
6131	Ward 7	7	681
6132	Ward 1	1	682
6133	Ward 2	2	682
6134	Ward 3	3	682
6135	Ward 4	4	682
6136	Ward 5	5	682
6137	Ward 6	6	682
6138	Ward 7	7	682
6139	Ward 1	1	683
6140	Ward 2	2	683
6141	Ward 3	3	683
6142	Ward 4	4	683
6143	Ward 5	5	683
6144	Ward 6	6	683
6145	Ward 7	7	683
6146	Ward 1	1	684
6147	Ward 2	2	684
6148	Ward 3	3	684
6149	Ward 4	4	684
6150	Ward 5	5	684
6151	Ward 6	6	684
6152	Ward 7	7	684
6153	Ward 1	1	685
6154	Ward 2	2	685
6155	Ward 3	3	685
6156	Ward 4	4	685
6157	Ward 5	5	685
6158	Ward 1	1	686
6159	Ward 2	2	686
6160	Ward 3	3	686
6161	Ward 4	4	686
6162	Ward 5	5	686
6163	Ward 1	1	687
6164	Ward 2	2	687
6165	Ward 3	3	687
6166	Ward 4	4	687
6167	Ward 5	5	687
6168	Ward 6	6	687
6169	Ward 7	7	687
6170	Ward 8	8	687
6171	Ward 9	9	687
6172	Ward 1	1	688
6173	Ward 2	2	688
6174	Ward 3	3	688
6175	Ward 4	4	688
6176	Ward 5	5	688
6177	Ward 6	6	688
6178	Ward 7	7	688
6179	Ward 8	8	688
6180	Ward 9	9	688
6181	Ward 1	1	689
6182	Ward 2	2	689
6183	Ward 3	3	689
6184	Ward 4	4	689
6185	Ward 5	5	689
6186	Ward 6	6	689
6187	Ward 7	7	689
6188	Ward 8	8	689
6189	Ward 9	9	689
6190	Ward 10	10	689
6191	Ward 1	1	690
6192	Ward 2	2	690
6193	Ward 3	3	690
6194	Ward 4	4	690
6195	Ward 5	5	690
6196	Ward 6	6	690
6197	Ward 7	7	690
6198	Ward 8	8	690
6199	Ward 9	9	690
6200	Ward 10	10	690
6201	Ward 1	1	691
6202	Ward 2	2	691
6203	Ward 3	3	691
6204	Ward 4	4	691
6205	Ward 5	5	691
6206	Ward 6	6	691
6207	Ward 7	7	691
6208	Ward 1	1	692
6209	Ward 2	2	692
6210	Ward 3	3	692
6211	Ward 4	4	692
6212	Ward 5	5	692
6213	Ward 1	1	693
6214	Ward 2	2	693
6215	Ward 3	3	693
6216	Ward 4	4	693
6217	Ward 5	5	693
6218	Ward 6	6	693
6219	Ward 1	1	694
6220	Ward 2	2	694
6221	Ward 3	3	694
6222	Ward 4	4	694
6223	Ward 5	5	694
6224	Ward 6	6	694
6225	Ward 7	7	694
6226	Ward 1	1	695
6227	Ward 2	2	695
6228	Ward 3	3	695
6229	Ward 4	4	695
6230	Ward 5	5	695
6231	Ward 6	6	695
6232	Ward 1	1	696
6233	Ward 2	2	696
6234	Ward 3	3	696
6235	Ward 4	4	696
6236	Ward 5	5	696
6237	Ward 6	6	696
6238	Ward 7	7	696
6239	Ward 8	8	696
6240	Ward 9	9	696
6241	Ward 10	10	696
6242	Ward 11	11	696
6243	Ward 1	1	697
6244	Ward 2	2	697
6245	Ward 3	3	697
6246	Ward 4	4	697
6247	Ward 5	5	697
6248	Ward 6	6	697
6249	Ward 7	7	697
6250	Ward 8	8	697
6251	Ward 9	9	697
6252	Ward 10	10	697
6253	Ward 1	1	698
6254	Ward 2	2	698
6255	Ward 3	3	698
6256	Ward 4	4	698
6257	Ward 5	5	698
6258	Ward 6	6	698
6259	Ward 7	7	698
6260	Ward 8	8	698
6261	Ward 9	9	698
6262	Ward 1	1	699
6263	Ward 2	2	699
6264	Ward 3	3	699
6265	Ward 4	4	699
6266	Ward 5	5	699
6267	Ward 6	6	699
6268	Ward 7	7	699
6269	Ward 8	8	699
6270	Ward 9	9	699
6271	Ward 10	10	699
6272	Ward 1	1	700
6273	Ward 2	2	700
6274	Ward 3	3	700
6275	Ward 4	4	700
6276	Ward 5	5	700
6277	Ward 6	6	700
6278	Ward 7	7	700
6279	Ward 8	8	700
6280	Ward 1	1	701
6281	Ward 2	2	701
6282	Ward 3	3	701
6283	Ward 4	4	701
6284	Ward 5	5	701
6285	Ward 6	6	701
6286	Ward 7	7	701
6287	Ward 1	1	702
6288	Ward 2	2	702
6289	Ward 3	3	702
6290	Ward 4	4	702
6291	Ward 5	5	702
6292	Ward 6	6	702
6293	Ward 7	7	702
6294	Ward 8	8	702
6295	Ward 9	9	702
6296	Ward 1	1	703
6297	Ward 2	2	703
6298	Ward 3	3	703
6299	Ward 4	4	703
6300	Ward 5	5	703
6301	Ward 6	6	703
6302	Ward 1	1	704
6303	Ward 2	2	704
6304	Ward 3	3	704
6305	Ward 4	4	704
6306	Ward 5	5	704
6307	Ward 6	6	704
6308	Ward 7	7	704
6309	Ward 8	8	704
6310	Ward 1	1	705
6311	Ward 2	2	705
6312	Ward 3	3	705
6313	Ward 4	4	705
6314	Ward 5	5	705
6315	Ward 6	6	705
6316	Ward 1	1	706
6317	Ward 2	2	706
6318	Ward 3	3	706
6319	Ward 4	4	706
6320	Ward 5	5	706
6321	Ward 6	6	706
6322	Ward 7	7	706
6323	Ward 8	8	706
6324	Ward 9	9	706
6325	Ward 1	1	707
6326	Ward 2	2	707
6327	Ward 3	3	707
6328	Ward 4	4	707
6329	Ward 5	5	707
6330	Ward 6	6	707
6331	Ward 7	7	707
6332	Ward 8	8	707
6333	Ward 9	9	707
6334	Ward 10	10	707
6335	Ward 11	11	707
6336	Ward 1	1	708
6337	Ward 2	2	708
6338	Ward 3	3	708
6339	Ward 4	4	708
6340	Ward 5	5	708
6341	Ward 6	6	708
6342	Ward 7	7	708
6343	Ward 1	1	709
6344	Ward 2	2	709
6345	Ward 3	3	709
6346	Ward 4	4	709
6347	Ward 5	5	709
6348	Ward 6	6	709
6349	Ward 7	7	709
6350	Ward 1	1	710
6351	Ward 2	2	710
6352	Ward 3	3	710
6353	Ward 4	4	710
6354	Ward 5	5	710
6355	Ward 6	6	710
6356	Ward 7	7	710
6357	Ward 1	1	711
6358	Ward 2	2	711
6359	Ward 3	3	711
6360	Ward 4	4	711
6361	Ward 5	5	711
6362	Ward 6	6	711
6363	Ward 1	1	712
6364	Ward 2	2	712
6365	Ward 3	3	712
6366	Ward 4	4	712
6367	Ward 5	5	712
6368	Ward 6	6	712
6369	Ward 1	1	713
6370	Ward 2	2	713
6371	Ward 3	3	713
6372	Ward 4	4	713
6373	Ward 5	5	713
6374	Ward 6	6	713
6375	Ward 7	7	713
6376	Ward 1	1	714
6377	Ward 2	2	714
6378	Ward 3	3	714
6379	Ward 4	4	714
6380	Ward 5	5	714
6381	Ward 1	1	715
6382	Ward 2	2	715
6383	Ward 3	3	715
6384	Ward 4	4	715
6385	Ward 5	5	715
6386	Ward 6	6	715
6387	Ward 7	7	715
6388	Ward 1	1	716
6389	Ward 2	2	716
6390	Ward 3	3	716
6391	Ward 4	4	716
6392	Ward 5	5	716
6393	Ward 6	6	716
6394	Ward 7	7	716
6395	Ward 1	1	717
6396	Ward 2	2	717
6397	Ward 3	3	717
6398	Ward 4	4	717
6399	Ward 5	5	717
6400	Ward 6	6	717
6401	Ward 7	7	717
6402	Ward 8	8	717
6403	Ward 1	1	718
6404	Ward 2	2	718
6405	Ward 3	3	718
6406	Ward 4	4	718
6407	Ward 5	5	718
6408	Ward 6	6	718
6409	Ward 7	7	718
6410	Ward 8	8	718
6411	Ward 1	1	719
6412	Ward 2	2	719
6413	Ward 3	3	719
6414	Ward 4	4	719
6415	Ward 5	5	719
6416	Ward 6	6	719
6417	Ward 7	7	719
6418	Ward 8	8	719
6419	Ward 1	1	720
6420	Ward 2	2	720
6421	Ward 3	3	720
6422	Ward 4	4	720
6423	Ward 5	5	720
6424	Ward 6	6	720
6425	Ward 1	1	721
6426	Ward 2	2	721
6427	Ward 3	3	721
6428	Ward 4	4	721
6429	Ward 5	5	721
6430	Ward 6	6	721
6431	Ward 7	7	721
6432	Ward 8	8	721
6433	Ward 9	9	721
6434	Ward 10	10	721
6435	Ward 11	11	721
6436	Ward 12	12	721
6437	Ward 13	13	721
6438	Ward 14	14	721
6439	Ward 1	1	722
6440	Ward 2	2	722
6441	Ward 3	3	722
6442	Ward 4	4	722
6443	Ward 5	5	722
6444	Ward 6	6	722
6445	Ward 7	7	722
6446	Ward 8	8	722
6447	Ward 9	9	722
6448	Ward 10	10	722
6449	Ward 1	1	723
6450	Ward 2	2	723
6451	Ward 3	3	723
6452	Ward 4	4	723
6453	Ward 5	5	723
6454	Ward 6	6	723
6455	Ward 7	7	723
6456	Ward 8	8	723
6457	Ward 9	9	723
6458	Ward 10	10	723
6459	Ward 11	11	723
6460	Ward 12	12	723
6461	Ward 13	13	723
6462	Ward 14	14	723
6463	Ward 1	1	724
6464	Ward 2	2	724
6465	Ward 3	3	724
6466	Ward 4	4	724
6467	Ward 5	5	724
6468	Ward 6	6	724
6469	Ward 7	7	724
6470	Ward 8	8	724
6471	Ward 9	9	724
6472	Ward 1	1	725
6473	Ward 2	2	725
6474	Ward 3	3	725
6475	Ward 4	4	725
6476	Ward 5	5	725
6477	Ward 1	1	726
6478	Ward 2	2	726
6479	Ward 3	3	726
6480	Ward 4	4	726
6481	Ward 5	5	726
6482	Ward 6	6	726
6483	Ward 7	7	726
6484	Ward 8	8	726
6485	Ward 1	1	727
6486	Ward 2	2	727
6487	Ward 3	3	727
6488	Ward 4	4	727
6489	Ward 5	5	727
6490	Ward 1	1	728
6491	Ward 2	2	728
6492	Ward 3	3	728
6493	Ward 4	4	728
6494	Ward 5	5	728
6495	Ward 1	1	729
6496	Ward 2	2	729
6497	Ward 3	3	729
6498	Ward 4	4	729
6499	Ward 5	5	729
6500	Ward 6	6	729
6501	Ward 1	1	730
6502	Ward 2	2	730
6503	Ward 3	3	730
6504	Ward 4	4	730
6505	Ward 5	5	730
6506	Ward 6	6	730
6507	Ward 7	7	730
6508	Ward 8	8	730
6509	Ward 9	9	730
6510	Ward 10	10	730
6511	Ward 11	11	730
6512	Ward 1	1	731
6513	Ward 2	2	731
6514	Ward 3	3	731
6515	Ward 4	4	731
6516	Ward 5	5	731
6517	Ward 6	6	731
6518	Ward 7	7	731
6519	Ward 8	8	731
6520	Ward 9	9	731
6521	Ward 10	10	731
6522	Ward 11	11	731
6523	Ward 12	12	731
6524	Ward 1	1	732
6525	Ward 2	2	732
6526	Ward 3	3	732
6527	Ward 4	4	732
6528	Ward 5	5	732
6529	Ward 6	6	732
6530	Ward 7	7	732
6531	Ward 8	8	732
6532	Ward 9	9	732
6533	Ward 10	10	732
6534	Ward 11	11	732
6535	Ward 12	12	732
6536	Ward 13	13	732
6537	Ward 14	14	732
6538	Ward 15	15	732
6539	Ward 16	16	732
6540	Ward 17	17	732
6541	Ward 18	18	732
6542	Ward 19	19	732
6543	Ward 1	1	733
6544	Ward 2	2	733
6545	Ward 3	3	733
6546	Ward 4	4	733
6547	Ward 5	5	733
6548	Ward 6	6	733
6549	Ward 7	7	733
6550	Ward 8	8	733
6551	Ward 9	9	733
6552	Ward 10	10	733
6553	Ward 11	11	733
6554	Ward 1	1	734
6555	Ward 2	2	734
6556	Ward 3	3	734
6557	Ward 4	4	734
6558	Ward 5	5	734
6559	Ward 6	6	734
6560	Ward 7	7	734
6561	Ward 8	8	734
6562	Ward 9	9	734
6563	Ward 10	10	734
6564	Ward 1	1	735
6565	Ward 2	2	735
6566	Ward 3	3	735
6567	Ward 4	4	735
6568	Ward 5	5	735
6569	Ward 6	6	735
6570	Ward 7	7	735
6571	Ward 8	8	735
6572	Ward 9	9	735
6573	Ward 10	10	735
6574	Ward 1	1	736
6575	Ward 2	2	736
6576	Ward 3	3	736
6577	Ward 4	4	736
6578	Ward 5	5	736
6579	Ward 6	6	736
6580	Ward 7	7	736
6581	Ward 8	8	736
6582	Ward 9	9	736
6583	Ward 10	10	736
6584	Ward 11	11	736
6585	Ward 12	12	736
6586	Ward 1	1	737
6587	Ward 2	2	737
6588	Ward 3	3	737
6589	Ward 4	4	737
6590	Ward 5	5	737
6591	Ward 6	6	737
6592	Ward 7	7	737
6593	Ward 8	8	737
6594	Ward 9	9	737
6595	Ward 10	10	737
6596	Ward 1	1	738
6597	Ward 2	2	738
6598	Ward 3	3	738
6599	Ward 4	4	738
6600	Ward 5	5	738
6601	Ward 6	6	738
6602	Ward 7	7	738
6603	Ward 8	8	738
6604	Ward 9	9	738
6605	Ward 1	1	739
6606	Ward 2	2	739
6607	Ward 3	3	739
6608	Ward 4	4	739
6609	Ward 5	5	739
6610	Ward 6	6	739
6611	Ward 1	1	740
6612	Ward 2	2	740
6613	Ward 3	3	740
6614	Ward 4	4	740
6615	Ward 5	5	740
6616	Ward 1	1	741
6617	Ward 2	2	741
6618	Ward 3	3	741
6619	Ward 4	4	741
6620	Ward 5	5	741
6621	Ward 6	6	741
6622	Ward 7	7	741
6623	Ward 8	8	741
6624	Ward 9	9	741
6625	Ward 1	1	742
6626	Ward 2	2	742
6627	Ward 3	3	742
6628	Ward 4	4	742
6629	Ward 5	5	742
6630	Ward 6	6	742
6631	Ward 7	7	742
6632	Ward 8	8	742
6633	Ward 9	9	742
6634	Ward 1	1	743
6635	Ward 2	2	743
6636	Ward 3	3	743
6637	Ward 4	4	743
6638	Ward 5	5	743
6639	Ward 6	6	743
6640	Ward 7	7	743
6641	Ward 1	1	744
6642	Ward 2	2	744
6643	Ward 3	3	744
6644	Ward 4	4	744
6645	Ward 5	5	744
6646	Ward 6	6	744
6647	Ward 1	1	745
6648	Ward 2	2	745
6649	Ward 3	3	745
6650	Ward 4	4	745
6651	Ward 5	5	745
6652	Ward 6	6	745
6653	Ward 7	7	745
6654	Ward 1	1	746
6655	Ward 2	2	746
6656	Ward 3	3	746
6657	Ward 4	4	746
6658	Ward 5	5	746
6659	Ward 6	6	746
6660	Ward 1	1	747
6661	Ward 2	2	747
6662	Ward 3	3	747
6663	Ward 4	4	747
6664	Ward 5	5	747
6665	Ward 6	6	747
6666	Ward 7	7	747
6667	Ward 8	8	747
6668	Ward 9	9	747
6669	Ward 1	1	748
6670	Ward 2	2	748
6671	Ward 3	3	748
6672	Ward 4	4	748
6673	Ward 5	5	748
6674	Ward 6	6	748
6675	Ward 7	7	748
6676	Ward 8	8	748
6677	Ward 9	9	748
6678	Ward 10	10	748
6679	Ward 11	11	748
6680	Ward 12	12	748
6681	Ward 1	1	749
6682	Ward 2	2	749
6683	Ward 3	3	749
6684	Ward 4	4	749
6685	Ward 5	5	749
6686	Ward 6	6	749
6687	Ward 7	7	749
6688	Ward 8	8	749
6689	Ward 9	9	749
6690	Ward 10	10	749
6691	Ward 1	1	750
6692	Ward 2	2	750
6693	Ward 3	3	750
6694	Ward 4	4	750
6695	Ward 5	5	750
6696	Ward 6	6	750
6697	Ward 7	7	750
6698	Ward 8	8	750
6699	Ward 9	9	750
6700	Ward 1	1	751
6701	Ward 2	2	751
6702	Ward 3	3	751
6703	Ward 4	4	751
6704	Ward 5	5	751
6705	Ward 6	6	751
6706	Ward 7	7	751
6707	Ward 8	8	751
6708	Ward 9	9	751
6709	Ward 10	10	751
6710	Ward 11	11	751
6711	Ward 12	12	751
6712	Ward 1	1	752
6713	Ward 2	2	752
6714	Ward 3	3	752
6715	Ward 4	4	752
6716	Ward 5	5	752
6717	Ward 6	6	752
6718	Ward 7	7	752
6719	Ward 8	8	752
6720	Ward 9	9	752
6721	Ward 10	10	752
6722	Ward 11	11	752
6723	Ward 1	1	753
6724	Ward 2	2	753
6725	Ward 3	3	753
6726	Ward 4	4	753
6727	Ward 5	5	753
6728	Ward 6	6	753
6729	Ward 7	7	753
6730	Ward 8	8	753
6731	Ward 9	9	753
6732	Ward 10	10	753
6733	Ward 11	11	753
6734	Ward 12	12	753
6735	Ward 13	13	753
6736	Ward 14	14	753
6737	Ward 15	15	753
6738	Ward 16	16	753
6739	Ward 17	17	753
6740	Ward 18	18	753
6741	Ward 19	19	753
\.


--
-- Name: achievements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.achievements_id_seq', 1, true);


--
-- Name: campaign_focuses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.campaign_focuses_id_seq', 2, true);


--
-- Name: candidate_details_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.candidate_details_id_seq', 3, true);


--
-- Name: candidate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.candidate_id_seq', 1881, true);


--
-- Name: controversies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.controversies_id_seq', 1, true);


--
-- Name: country_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.country_id_seq', 1, false);


--
-- Name: district_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.district_id_seq', 1, false);


--
-- Name: municipalities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.municipalities_id_seq', 1, false);


--
-- Name: political_experiences_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.political_experiences_id_seq', 11, true);


--
-- Name: positive_contributions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.positive_contributions_id_seq', 3, true);


--
-- Name: province_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.province_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 35, true);


--
-- Name: wards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.wards_id_seq', 6741, true);


--
-- Name: achievements achievements_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.achievements
    ADD CONSTRAINT achievements_pkey PRIMARY KEY (id);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: campaign_focuses campaign_focuses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.campaign_focuses
    ADD CONSTRAINT campaign_focuses_pkey PRIMARY KEY (id);


--
-- Name: candidate_details candidate_details_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.candidate_details
    ADD CONSTRAINT candidate_details_pkey PRIMARY KEY (id);


--
-- Name: candidate candidate_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.candidate
    ADD CONSTRAINT candidate_pkey PRIMARY KEY (id);


--
-- Name: controversies controversies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.controversies
    ADD CONSTRAINT controversies_pkey PRIMARY KEY (id);


--
-- Name: country country_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_code_key UNIQUE (code);


--
-- Name: country country_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_name_key UNIQUE (name);


--
-- Name: country country_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_pkey PRIMARY KEY (id);


--
-- Name: district district_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.district
    ADD CONSTRAINT district_pkey PRIMARY KEY (id);


--
-- Name: municipalities municipalities_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.municipalities
    ADD CONSTRAINT municipalities_pkey PRIMARY KEY (id);


--
-- Name: political_experiences political_experiences_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.political_experiences
    ADD CONSTRAINT political_experiences_pkey PRIMARY KEY (id);


--
-- Name: positive_contributions positive_contributions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.positive_contributions
    ADD CONSTRAINT positive_contributions_pkey PRIMARY KEY (id);


--
-- Name: province province_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.province
    ADD CONSTRAINT province_name_key UNIQUE (name);


--
-- Name: province province_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.province
    ADD CONSTRAINT province_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: wards wards_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wards
    ADD CONSTRAINT wards_pkey PRIMARY KEY (id);


--
-- Name: ix_candidate_details_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_candidate_details_id ON public.candidate_details USING btree (id);


--
-- Name: ix_candidate_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_candidate_id ON public.candidate USING btree (id);


--
-- Name: ix_country_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_country_id ON public.country USING btree (id);


--
-- Name: ix_district_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_district_id ON public.district USING btree (id);


--
-- Name: ix_municipalities_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_municipalities_id ON public.municipalities USING btree (id);


--
-- Name: ix_province_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_province_id ON public.province USING btree (id);


--
-- Name: ix_users_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_users_id ON public.users USING btree (id);


--
-- Name: ix_wards_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_wards_id ON public.wards USING btree (id);


--
-- Name: achievements achievements_candidate_details_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.achievements
    ADD CONSTRAINT achievements_candidate_details_id_fkey FOREIGN KEY (candidate_details_id) REFERENCES public.candidate_details(id) ON DELETE CASCADE;


--
-- Name: campaign_focuses campaign_focuses_candidate_details_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.campaign_focuses
    ADD CONSTRAINT campaign_focuses_candidate_details_id_fkey FOREIGN KEY (candidate_details_id) REFERENCES public.candidate_details(id) ON DELETE CASCADE;


--
-- Name: candidate_details candidate_details_candidate_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.candidate_details
    ADD CONSTRAINT candidate_details_candidate_id_fkey FOREIGN KEY (candidate_id) REFERENCES public.candidate(id) ON DELETE CASCADE;


--
-- Name: candidate candidate_district_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.candidate
    ADD CONSTRAINT candidate_district_id_fkey FOREIGN KEY (district_id) REFERENCES public.district(id) ON DELETE SET NULL;


--
-- Name: candidate candidate_province_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.candidate
    ADD CONSTRAINT candidate_province_id_fkey FOREIGN KEY (province_id) REFERENCES public.province(id) ON DELETE SET NULL;


--
-- Name: controversies controversies_candidate_details_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.controversies
    ADD CONSTRAINT controversies_candidate_details_id_fkey FOREIGN KEY (candidate_details_id) REFERENCES public.candidate_details(id) ON DELETE CASCADE;


--
-- Name: district district_province_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.district
    ADD CONSTRAINT district_province_id_fkey FOREIGN KEY (province_id) REFERENCES public.province(id) ON DELETE CASCADE;


--
-- Name: municipalities municipalities_district_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.municipalities
    ADD CONSTRAINT municipalities_district_id_fkey FOREIGN KEY (district_id) REFERENCES public.district(id) ON DELETE CASCADE;


--
-- Name: political_experiences political_experiences_candidate_details_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.political_experiences
    ADD CONSTRAINT political_experiences_candidate_details_id_fkey FOREIGN KEY (candidate_details_id) REFERENCES public.candidate_details(id) ON DELETE CASCADE;


--
-- Name: positive_contributions positive_contributions_candidate_details_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.positive_contributions
    ADD CONSTRAINT positive_contributions_candidate_details_id_fkey FOREIGN KEY (candidate_details_id) REFERENCES public.candidate_details(id) ON DELETE CASCADE;


--
-- Name: province province_country_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.province
    ADD CONSTRAINT province_country_id_fkey FOREIGN KEY (country_id) REFERENCES public.country(id) ON DELETE CASCADE;


--
-- Name: wards wards_municipality_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wards
    ADD CONSTRAINT wards_municipality_id_fkey FOREIGN KEY (municipality_id) REFERENCES public.municipalities(id);


--
-- PostgreSQL database dump complete
--

\unrestrict h0qn6ifAjmIvLcLvLwGw6MBPnSWw4MPg3nT5c9yjB080uKQtmHl2Fj2MtFoWpmx

