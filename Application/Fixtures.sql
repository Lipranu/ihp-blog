

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


SET SESSION AUTHORIZATION DEFAULT;

ALTER TABLE public.posts DISABLE TRIGGER ALL;

INSERT INTO public.posts (id, title, body, created_at) VALUES ('a30a1647-2ccb-486c-b78d-e5a6a8ec4aea', 'Hello World!', 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam', '2021-06-20 20:13:38.446336+07');
INSERT INTO public.posts (id, title, body, created_at) VALUES ('cf146573-de11-4175-8951-6741f456d416', 'title test', 'body test', '2021-06-20 20:13:38.449355+07');
INSERT INTO public.posts (id, title, body, created_at) VALUES ('11b2864f-3ed4-42a8-8b65-c5408d925f9b', 'time test', 'its about time', '2021-06-20 20:20:40.640807+07');
INSERT INTO public.posts (id, title, body, created_at) VALUES ('1efc5a08-e0a3-4ef5-b6c0-b34363b0d4ea', 'mark test', '# mark
lines
lines
## kl:
* j
* k', '2021-06-20 21:07:19.439233+07');


ALTER TABLE public.posts ENABLE TRIGGER ALL;


ALTER TABLE public.comments DISABLE TRIGGER ALL;

INSERT INTO public.comments (id, post_id, author, body) VALUES ('183230bb-9363-49bd-9a34-c94c4db04517', '11b2864f-3ed4-42a8-8b65-c5408d925f9b', 'Lip', 'First Comment');
INSERT INTO public.comments (id, post_id, author, body) VALUES ('843f7555-e810-48e3-9b06-29b792f79ccb', '1efc5a08-e0a3-4ef5-b6c0-b34363b0d4ea', 'Lip', 'Second Comment');
INSERT INTO public.comments (id, post_id, author, body) VALUES ('40c2ee06-fdd0-488b-86b7-7219c2b0685f', '1efc5a08-e0a3-4ef5-b6c0-b34363b0d4ea', 'Bob', 'Third Comment');


ALTER TABLE public.comments ENABLE TRIGGER ALL;


