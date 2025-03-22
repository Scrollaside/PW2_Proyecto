USE pw2;

-- TRUNCATE TABLE usuario; --

INSERT INTO usuario (nombre_usuario, nickname_usuario, foto_usuario, desc_usuario, email_usuario, contrasenia_usuario) VALUES
('User Test One', 'UserTest01', 0, 'User Description', 'email@mail.com', 'Userpass1!');

INSERT INTO usuario (foto_usuario, nombre_usuario, nickname_usuario, desc_usuario, email_usuario, contrasenia_usuario) VALUES 
(0, 'Danny B.', 'moshiOnO', 'Me gusta comer xD', 'moshiuwu@uanl.edu.mx', 'mipapáesfox#20'),
(0, 'Prueba Es mi Nombre', 'prueba', 'soy una prueba', NULL, 'prueba'),
(0, 'Sei', 'seis', 'soy el usuario seis', NULL, 'seis'),
(0, NULL, 'pro2', NULL, NULL, NULL),
(0, 'Sonic is my Name', 'TheBlueH', 'I like CHili dogs and minecraft :3', 'sonic@gmail.com', 'Contraseña#20');


-- TRUNCATE TABLE publicacion; --

INSERT INTO publicacion (id_post, id_autor, titulo_post, desc_post, fecha_post, foto_post) VALUES 
(1, 1, 'March 7th', 'OMG, just starting playing HSR and i LOVE this living protogem', '2017-05-17 20:47:09', 0),
(5, 1, 'Yanfo', 'Vete alaberga, me llevo como 30 min acabar esta wea conchetumadre, pero como la amo uwu', '2024-05-18 14:18:18', 0),
(6, 6, 'Uraraka sketchie', 'Un skecth rapidito que hice', '2024-05-17 15:32:59', 0),
(8, 1, 'Hu TAOOOOOOOO', 'Como quiero a la Hu tao', '2024-05-18 14:27:16', 0),
(9, 6, 'Makoto Yuki', 'March 5th ....', '2024-05-19 14:37:17', 0);


-- TRUNCATE TABLE categoria --

INSERT INTO categoria (id_cat, title_cat) VALUES
(1, 'anime'),
(2, '2d'),
(3, 'oc'),
(4, 'illustration'),
(5, 'nintendo'),
(6, 'marvel'),
(7, 'dc'),
(8, 'youtube'),
(9, 'drawing'),
(10, 'sketch'),
(11, 'digital'),
(12, 'Cats');


-- TRUNCATE TABLE comentario --

INSERT INTO comentario (id_comm, id_usuario, desc_comm, fecha_comm) VALUES
(1, 1, 'Holaaaaa', '2024-05-15 16:43:25'),
(6, 1, 'asdsd', NULL),
(7, 1, 'ala', NULL),
(8, 1, 'este comentario tendrá una cantidad excesiva de texto xD', NULL),
(9, 6, 'Ta bien bonita tu yanfooooo', NULL),
(10, 6, 'Mucho texto, ya kys', NULL),
(11, 1, 'Holi, primer comentario', NULL);


-- TRUNCATE TABLE follow --

INSERT INTO follow (id_follow, id_usuario, id_ufollowed, fecha_follow) VALUES
(1, 1, 1, '2024-05-12 14:02:23'),
(2, 2, 1, '2024-05-12 14:04:06'),
(9, 6, 1, '2024-05-19 14:29:30');


-- TRUNCATE TABLE likes --

INSERT INTO likes (id_like, id_usuario, id_post, fecha_like) VALUES
(6, 1, 5, '2024-05-18 12:16:20'),
(7, 1, 1, '2024-05-18 12:16:25'),
(9, 1, 8, '2024-05-19 12:57:28'),
(10, 6, 1, '2024-05-19 14:29:29');

-- TRUNCATE TABLE post_cat --

INSERT INTO post_cat (id_pcat, id_cat, id_post) VALUES
(6, 1, 6),
(7, 8, 6),
(8, 9, 6),
(17, 1, 8),
(18, 2, 8),
(19, 4, 8),
(22, 1, 1),
(23, 8, 1),
(24, 1, 5),
(25, 2, 5),
(26, 4, 5),
(27, 1, 9),
(28, 4, 9),
(29, 9, 9);


-- TRUNCATE TABLE post_comm --

INSERT INTO post_comm (id_pcomm, id_comm, id_post) VALUES
(1, 1, 1),
(2, 6, 1),
(3, 7, 1),
(4, 8, 1),
(5, 9, 5),
(6, 10, 1),
(7, 11, 6);


-- TRUNCATE TABLE usu_cat --

INSERT INTO usu_cat (id_usucat, id_usuario, id_cat) VALUES
(1, 1, 3);


