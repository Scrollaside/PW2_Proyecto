USE pw2;

DROP PROCEDURE IF EXISTS borrarposts_byid;
DELIMITER //
CREATE PROCEDURE borrarPosts_byid (
	IN pub_id INT
)   
	BEGIN
    -- Eliminar de la tabla likes 
    DELETE FROM likes WHERE id_post = pub_id;
    -- Eliminar de la tabla de post_likes
    DELETE FROM post_likes WHERE id_post = pub_id;
    -- Eliminar de la tabla de comentarios
    DELETE FROM post_comm WHERE id_post = pub_id;
    -- Eliminar de la tabla de categorías
    DELETE FROM post_cat WHERE id_post = pub_id;
    -- Eliminar la postcación
    DELETE FROM publicacion WHERE id_post = pub_id;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS borrarPosts_byname;
DELIMITER //
CREATE PROCEDURE borrarPosts_byname (
	IN nombre_publicacion VARCHAR(255)
)   
BEGIN
    DECLARE pub_id INT;
    -- Obtener el id de la postcación a partir del nombre
    SELECT id_post INTO pub_id FROM publicacion WHERE titulo_post = nombre_publicacion;
    -- Eliminar de la tabla likes 
    DELETE FROM likes WHERE id_post = pub_id;
    -- Eliminar de la tabla de post_likes
    DELETE FROM post_likes WHERE id_post = pub_id;
    -- Eliminar de la tabla de comentarios
    DELETE FROM post_comm WHERE id_post = pub_id;
    -- Eliminar de la tabla de categorías
    DELETE FROM post_cat WHERE id_post = pub_id;
    -- Eliminar la postcación
    DELETE FROM publicacion WHERE id_post = pub_id;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS getCategorias;
DELIMITER //
CREATE PROCEDURE getCategorias (
	IN pubId INT
)   
BEGIN
    SELECT cat.title_cat
    FROM categoria cat
    JOIN post_cat pc ON cat.id_cat = pc.id_cat
    WHERE pc.id_post = pubId;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS getComentarios;
DELIMITER //
CREATE PROCEDURE getComentarios (
	IN pubId INT
)   
BEGIN
    SELECT c.id_comm, u.foto_usuario, u.nickname_usuario AS username, c.desc_comm
    FROM comentario c
    JOIN post_comm pc ON c.id_comm = pc.id_comm
    JOIN usuario u ON c.id_usuario = u.id_usuario
    WHERE pc.id_post = pubId;
END //
DELIMITER;

DROP PROCEDURE IF EXISTS getInteraccionesSemanales;
DELIMITER //
CREATE PROCEDURE getInteraccionesSemanales (
	IN userId INT
    )   
BEGIN
    SELECT 
        CONCAT(YEAR(IFNULL(l.fecha_like, c.fecha_comm)), '-', WEEK(IFNULL(l.fecha_like, c.fecha_comm), 1)) AS semana, 
        COUNT(DISTINCT c.id_comm) AS comentarios, 
        COUNT(DISTINCT l.id_like) AS likes 
    FROM publicacion p
    LEFT JOIN post_comm pc ON p.id_post = pc.id_post
    LEFT JOIN comentario c ON pc.id_comm = c.id_comm
    LEFT JOIN likes l ON p.id_post = l.id_post
    WHERE p.id_autor = userId 
    GROUP BY semana;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS getPublicacion;
DELIMITER //
CREATE PROCEDURE getPublicacion (
	IN pubId INT
)   
BEGIN
    SELECT p.id_autor, p.id_post, p.foto_post, p.fecha_post, p.titulo_post, p.desc_post, u.foto_usuario, u.nickname_usuario AS autorNombre
    FROM publicacion p
    JOIN usuario u ON p.id_autor = u.id_usuario
    WHERE p.id_post = pubId;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS getPublicacionesLikes;
DELIMITER //
CREATE PROCEDURE getPublicacionesLikes (
	IN userId INT
)   
BEGIN
    SELECT 
        CASE DAYNAME(l.fecha_like)
            WHEN 'Monday' THEN 'Lunes'
            WHEN 'Tuesday' THEN 'Martes'
            WHEN 'Wednesday' THEN 'Miércoles'
            WHEN 'Thursday' THEN 'Jueves'
            WHEN 'Friday' THEN 'Viernes'
            WHEN 'Saturday' THEN 'Sábado'
            WHEN 'Sunday' THEN 'Domingo'
        END AS dia, 
        COUNT(l.id_like) AS likes
    FROM likes l
    JOIN publicacion p ON l.id_post = p.id_post
    WHERE p.id_autor = userId
    GROUP BY dia;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS getRecientesAutor;
DELIMITER //
CREATE PROCEDURE getRecientesAutor (
	IN pubId INT
)   
BEGIN
    SELECT p.id_post, p.foto_post
    FROM publicacion p
    WHERE p.id_autor = (SELECT id_autor FROM publicacion WHERE id_post = pubId)
      AND p.id_post != pubId
    ORDER BY p.fecha_post DESC
    LIMIT 3;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS getRecomendaciones;
DELIMITER //
CREATE PROCEDURE getRecomendaciones (
	IN pubId INT
)   
BEGIN
    SELECT DISTINCT p.id_post, p.foto_post
    FROM publicacion p
    JOIN post_cat pc ON p.id_post = pc.id_post
    JOIN post_cat pc2 ON pc.id_cat = pc2.id_cat
    WHERE pc2.id_post = pubId AND p.id_post != pubId
    LIMIT 3;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS getSeguidoresMensuales;
DELIMITER //
CREATE PROCEDURE getSeguidoresMensuales (
	IN userId INT
)   
BEGIN
    SELECT 
        DATE_FORMAT(f.fecha_follow, '%Y-%m') AS mes, 
        COUNT(f.id_usuario) AS seguidores 
    FROM follow f 
    WHERE f.id_ufollowed = userId 
    GROUP BY mes;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS posts_cat;
DELIMITER //
CREATE PROCEDURE posts_cat (
	IN usuario_id INT
)   
BEGIN
    -- Declara una variable para almacenar el ID de la categoría
    DECLARE categoria_id INT;

    -- Declara un cursor para obtener los IDs de categorías relacionadas al usuario
    DECLARE cur CURSOR FOR
        SELECT DISTINCT id_cat
        FROM usu_cat
        WHERE id_usuario = usuario_id;

    -- Declara un manejador de errores para el cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET categoria_id = NULL;

    -- Abre el cursor
    OPEN cur;

    -- Inicializa la variable
    SET categoria_id = NULL;

    -- Recorre los resultados del cursor
    read_loop: LOOP
        FETCH cur INTO categoria_id;

        -- Sal del bucle si no hay más resultados
        IF categoria_id IS NULL THEN
            LEAVE read_loop;
        END IF;

        -- Obtiene todas las publicaciones relacionadas a la categoría actual
        SELECT DISTINCT p.id_post, p.titulo_post, p.desc_post
        FROM publicacion p
        INNER JOIN post_cat pc ON p.id_post = pc.id_post
        WHERE pc.id_cat = categoria_id;

    END LOOP;

    -- Cierra el cursor
    CLOSE cur;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS posts_newtoold;
DELIMITER //
CREATE PROCEDURE posts_newtoold ()   
BEGIN
    -- Selecciona las publicaciones ordenadas del más nuevo al más viejo
    SELECT id_post, titulo_post, desc_post, foto_post
    FROM publicacion
    ORDER BY fecha_post DESC;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS posts_ufollowed;
DELIMITER //
CREATE PROCEDURE posts_ufollowed (
	IN usuario_id INT
)   
BEGIN
    SELECT p.id_post, p.titulo_post, p.foto_post
    FROM follow f
    JOIN publicacion p ON f.id_ufollowed = p.id_autor
    WHERE f.id_usuario = usuario_id;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS post_cat_p;
DELIMITER //
CREATE PROCEDURE post_cat_p (
	IN id_postT INT, IN nombre_cat VARCHAR(255)
)   
BEGIN

    DECLARE categoria_idT INT;
 -- Obtener el ID de la categoría
    SELECT id_cat INTO categoria_idT
    FROM categoria
    WHERE title_cat = nombre_cat;

    -- Insertar una fila en la tabla intermedia
    INSERT INTO post_cat (id_post, id_cat)
    VALUES (id_postT, categoria_idT);
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS usu_cat_p;
DELIMITER //
CREATE PROCEDURE usu_cat_p (
	IN usuario_id INT, IN publicacion_id INT
)   
BEGIN
    -- Declara una variable para almacenar el ID de la categoría
    DECLARE categoria_id INT;

    -- Declara una variable para almacenar temporalmente los resultados del cursor
    DECLARE rows_affected INT;

    -- Declara un cursor para almacenar los resultados de la consulta
    DECLARE cur CURSOR FOR
        SELECT id_cat
        FROM post_cat
        WHERE id_post = publicacion_id;

    -- Declara un manejador de errores para el cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET categoria_id = NULL;

    -- Abre el cursor
    OPEN cur;

    -- Inicializa la variable
    SET categoria_id = NULL;

    -- Inicializa la variable rows_affected
    SET rows_affected = 0;

    -- Recorre los resultados del cursor
    read_loop: LOOP
        FETCH cur INTO categoria_id;

        -- Sal del bucle si no hay más resultados
        IF categoria_id IS NULL THEN
            LEAVE read_loop;
        END IF;

        -- Verificar si ya existe una entrada en la tabla intermedia para este par de IDs
        SELECT COUNT(*)
        INTO rows_affected
        FROM usu_cat
        WHERE id_usuario = usuario_id AND id_cat = categoria_id;

        -- Si no existe una entrada, insertarla; de lo contrario, no hacer nada
        IF rows_affected = 0 THEN
            INSERT INTO usu_cat (id_usuario, id_cat)
            VALUES (usuario_id, categoria_id);
        END IF;
    END LOOP;

    -- Cierra el cursor
    CLOSE cur;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS validar_registro;
DELIMITER //
CREATE PROCEDURE validar_registro (
	IN p_usuario VARCHAR(255), 
	IN p_apodo VARCHAR(255), 
	IN p_correo VARCHAR(255), 
	OUT p_error VARCHAR(255)
)   
BEGIN
    DECLARE usuario_count INT;
    DECLARE correo_count INT;

    -- Verificar si el usuario ya existe
    SELECT COUNT(*) INTO usuario_count FROM usuario WHERE nombre_usuario = p_usuario;
    
    -- Verificar si el correo ya está en uso
    SELECT COUNT(*) INTO correo_count FROM usuario WHERE email_usuario = p_correo;

    IF usuario_count > 0 THEN
        SET p_error = 'El nombre de usuario ya está en uso.';
    ELSEIF correo_count > 0 THEN
        SET p_error = 'El correo electrónico ya está en uso.';
    ELSE
        -- Si el usuario y el correo no están en uso, no hay error
        SET p_error = '';
    END IF;
END //
DELIMITER ;
