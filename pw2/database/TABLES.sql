DROP DATABASE IF EXISTS PW2;
CREATE DATABASE PW2;
USE PW2;

DROP TABLE IF EXISTS usuario;
CREATE TABLE usuario (
	id_usuario INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	nombre_usuario varchar(50) DEFAULT NULL,
	nickname_usuario varchar(50) DEFAULT NULL,
	foto_usuario mediumblob DEFAULT NULL,
	desc_usuario varchar(255) DEFAULT NULL,
	email_usuario varchar(50) DEFAULT NULL,
	contrasenia_usuario varchar(50) DEFAULT NULL
);

DROP TABLE IF EXISTS publicacion;
CREATE TABLE publicacion (
	id_post INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	id_autor INT DEFAULT NULL,
	titulo_post varchar(50) DEFAULT NULL,
	desc_post varchar(255) DEFAULT NULL,
	fecha_post datetime DEFAULT NULL,
	foto_post mediumblob DEFAULT NULL,
    
	FOREIGN KEY (id_autor) REFERENCES usuario (id_usuario)
);
  
DROP TABLE IF EXISTS categoria;
CREATE TABLE categoria (
  id_cat INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  title_cat varchar(55) DEFAULT NULL
);

DROP TABLE IF EXISTS comentario;
CREATE TABLE comentario (
  id_comm INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  id_usuario INT DEFAULT NULL,
  desc_comm varchar(255) DEFAULT NULL,
  fecha_comm datetime DEFAULT NULL,
  
  FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario)
);

DROP TABLE IF EXISTS follow;
CREATE TABLE follow (
  id_follow INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  id_usuario INT DEFAULT NULL,
  id_ufollowed INT DEFAULT NULL,
  fecha_follow datetime DEFAULT NULL,
  
  FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario),
  FOREIGN KEY (id_ufollowed) REFERENCES usuario (id_usuario)
);

DROP TABLE IF EXISTS interaccion;
CREATE TABLE interaccion (
  id_inter INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  id_usuario INT DEFAULT NULL,
  likesnum INT DEFAULT NULL,
  commnum INT DEFAULT NULL,
  suma INT DEFAULT NULL,
  fecha_inter datetime DEFAULT NULL,
  
  FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario)
);

DROP TABLE IF EXISTS likes;
CREATE TABLE likes (
  id_like INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  id_usuario INT DEFAULT NULL,
  id_post INT DEFAULT NULL,
  fecha_like datetime DEFAULT NULL,
  
  FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario),
  FOREIGN KEY (id_post) REFERENCES publicacion (id_post)
);

DROP TABLE IF EXISTS visualizacion;
CREATE TABLE visualizacion (
  id_vis INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  id_usuario INT DEFAULT NULL,
  id_post INT DEFAULT NULL,
  fecha_vis datetime DEFAULT NULL,
  
  FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario),
  FOREIGN KEY (id_post) REFERENCES publicacion (id_post)
);

DROP TABLE IF EXISTS usu_cat;
CREATE TABLE usu_cat (
  id_usucat INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  id_usuario INT DEFAULT NULL,
  id_cat INT DEFAULT NULL,
  
  FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario),
  FOREIGN KEY (id_cat) REFERENCES categoria (id_cat)
);

DROP TABLE IF EXISTS post_cat;
CREATE TABLE post_cat (
  id_pcat INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  id_cat INT DEFAULT NULL,
  id_post INT DEFAULT NULL,
  
  FOREIGN KEY (id_cat) REFERENCES categoria (id_cat),
  FOREIGN KEY (id_post) REFERENCES publicacion (id_post)
);

DROP TABLE IF EXISTS post_comm;
CREATE TABLE post_comm (
  id_pcomm INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  id_comm INT DEFAULT NULL,
  id_post INT DEFAULT NULL,
  
  FOREIGN KEY (id_comm) REFERENCES comentario (id_comm),
  FOREIGN KEY (id_post) REFERENCES publicacion (id_post)
);

DROP TABLE IF EXISTS post_likes;
CREATE TABLE post_likes (
  id_pl INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  id_like INT DEFAULT NULL,
  id_post INT DEFAULT NULL,
  
  FOREIGN KEY (id_like) REFERENCES likes (id_like),
  FOREIGN KEY (id_post) REFERENCES publicacion (id_post)
);

