USE pw2;
TRUNCATE TABLE usuario;

INSERT INTO usuario (nombre_usuario, nickname_usuario, foto_usuario, desc_usuario, email_usuario, contrasenia_usuario) VALUES
('User Test One', 'UserTest01', 0, 'User Description', 'email@mail.com', 'Userpass1!');

SELECT * FROM usuario;