const express = require('express');
const app = express();
const cors = require('cors');
const mysql = require('mysql');
const multer = require('multer');
const session = require('express-session');
// const RedisStore = require("connect-redis").default;
// const redis = require("redis");

// const redisClient = redis.createClient({ url: process.env.VALKEY_URL });
app.set('trust proxy', 1); // Trust first proxy

app.use(cors({
    // origin: 'http://localhost:3000', // Ajusta esto al puerto donde corre tu React app
    origin: 'https://front.webart.infinityfreeapp.com',
    credentials: true // Permitir el envío de cookies
}));
app.use(express.json());

//Session
app.use(session({
    secret: 'secret_key',
    // store: new RedisStore({ client: redisClient }),
    resave: false,
    saveUninitialized: false,
    cookie: {
        secure: true,
        samesite: 'none'
        //maxAge: 1000 * 60 * 60 * 24 // Cookie válida por un día
    },
    name: 'id_usuario'
}));

//Verificar sesión existente
function verificarSesion(req, res, next) {
    if (req.session.userId) {
        next(); // El usuario está logueado, continuar con la solicitud
    } else {
        res.status(401).send("No autorizado"); // No logueado, enviar error
    }
}

//Configuración del servidor
const PORT = process.env.PORT || 3001;
app.listen(PORT, () => {
    console.log(`Listening Port ${PORT}`);
});
app.get('/', (req, res) => {
    res.send('Hola');
});

//
const hostname = "flava.h.filess.io";
const database = "pw2_gameround";
const port = "3307";
const username = "pw2_gameround";
const password = "MYSQLpass";
//

const db = mysql.createConnection(
    {
        // host: "localhost",
        // user: "root",
        // password: "MYSQLpass", 
        // database: "pw2"

        
        host: hostname,
        user: username,
        password: password,
        database: database,
        port: port
        
    }
)

//Para las imágenes
const fileFil = (req, file, cb) => {
    // reject a file
    if (file.mimetype === 'image/png' || file.mimetype === 'image/jpeg' || file.mimetype === 'image/jpg') {
        cb(null, true);
    } else {
        cb(null, false);

        return cb(new Error('Only .png, .jpg and .jpeg format allowed!'));
    }
};
const strg = multer.memoryStorage();
const upload = multer({
    storage: strg,
    fileFilter: fileFil
})


//******************************Inicio y coregistro de sesión ************************
// Modifica la ruta "/registro" para incluir el apodo (nickname) del usuario
// app.post("/registro", redirigirSiAutenticado, (req, res) => {
//     const { name, nickN, mail, pass } = req.body;

//     const sql = 'INSERT INTO usuario (nombre_usuario, nickname_usuario, email_usuario, contrasenia_usuario) VALUES (?, ?, ?, ?)';
//     db.query(sql, [name, nickN, mail, pass], (err, result) => {
//         if (err) {
//             res.status(500).send('Error al registrar el usuario');
//             throw err;
//         }
//         res.status(200).send('Usuario registrado exitosamente');
//     });
// });
// Modifica la ruta "/create" para incluir el apodo (nickname) del usuario
app.post("/create", (req, resp) => {
    const usu = req.body.usuario;
    const nick = req.body.apodo;
    const correo = req.body.correo;
    const passw = req.body.contra;

    // Llamar al procedimiento almacenado validar_registro
    db.query('CALL validar_registro(?, ?, ?, @error)', [usu, nick, correo], (err, result) => {
        if (err) {
            console.log(err);
            return resp.status(500).send("Error al validar el registro");
        }

        // Recuperar el mensaje de error si existe
        db.query('SELECT @error AS error', (err, results) => {
            if (err) {
                console.log(err);
                return resp.status(500).send("Error al obtener el resultado de la validación");
            }

            const error = results[0].error;
            if (error) {
                // Si hay un error, enviar el mensaje de error
                return resp.status(400).send(error);
            } else {
                // Si no hay error, proceder con la inserción del usuario
                db.query('INSERT INTO usuario (nombre_usuario, nickname_usuario, email_usuario, contrasenia_usuario) VALUES (?, ?, ?, ?)',
                    [usu, nick, correo, passw], 
                    (err, data) => {
                        if (err) {
                            console.log(err);
                            return resp.status(500).send("Error al registrar el usuario");
                        } else {
                            const userId = data.insertId;  // Usar data.insertId para obtener el ID del nuevo usuario
                            req.session.userId = userId;
                            // resp.cookie('id_usuario', userId, {
                            //     httpOnly: true,
                            //     maxAge: 1000 * 60 * 60 * 24 // 1 día
                            // });
                            resp.status(201).send("Usuario registrado exitosamente");
                        }
                    }
                );
            }
        });
    });
});

//Login para almacenar cosas 
app.post("/login", (req, resp) => {
    db.query("SELECT * FROM usuario WHERE nickname_usuario = ? AND contrasenia_usuario = ?", [req.body.us, req.body.con], (err, data) => {
        if (err) {
            console.error("Error en la consulta:", err);
            resp.status(500).send(err); // Manejar errores de base de datos
        } else {
            if (data.length > 0) {
                req.session.userId = data[0].id_usuario; // Almacenar el ID del usuario en la sesión                
                resp.json({ alert: 'Success' }); // Usuario encontrado
            } else {
                resp.json({ alert: 'IncorrectPassword' }); // Contraseña incorrecta o usuario no encontrado
            }
        }
    });
});
//***************************************************************************************
//***************************************************************************************
//***************************************************************************************



// Obtener info general del usuario para el menú
app.get("/perfilMenu", verificarSesion, (req, res) => {
    const userId = req.session.userId;
    if (userId) {
        db.query("SELECT * FROM usuario WHERE id_usuario = ?", [userId], (err, result) => {
            if (err) {
                return res.status(500).send("Error al recuperar la información del usuario");
            }
            if (result.length > 0) {
                const usuario = result[0];
                const foto = usuario.foto_usuario ? Buffer.from(usuario.foto_usuario).toString('base64') : null;
                res.json({
                    id: usuario.id_usuario,
                    nombre: usuario.nombre_usuario,
                    nickname: usuario.nickname_usuario,
                    email: usuario.email_usuario,
                    descripcion: usuario.desc_usuario,
                    foto: foto ? `data:image/jpeg;base64,${foto}` : null
                });
            } else {
                res.status(404).send("Usuario no encontrado.");
            }
        });
    } else {
        res.status(401).send("Usuario no autenticado.");
    }
});



//******************************Perfil del usuario************************
// Ruta para obtener el perfil de un usuario por su ID
app.get("/perfil/:userId", verificarSesion, (req, res) => {
    const userId = req.params.userId;
    db.query("SELECT * FROM usuario WHERE id_usuario = ?", [userId], (err, result) => {
        if (err) {
            return res.status(500).send("Error al recuperar la información del usuario");
        }
        if (result.length > 0) {
            const usuario = result[0];
            const foto = usuario.foto_usuario ? Buffer.from(usuario.foto_usuario).toString('base64') : null;
            res.json({
                id: usuario.id_usuario,
                nombre: usuario.nombre_usuario,
                nickname: usuario.nickname_usuario,
                email: usuario.email_usuario,
                descripcion: usuario.desc_usuario,
                foto: foto ? `data:image/jpeg;base64,${foto}` : null
            });
        } else {
            res.status(404).send("Usuario no encontrado.");
        }
    });
});
// Ruta para obtener las publicaciones de un usuario por su ID
app.get('/userPosts/:userId', verificarSesion, (req, res) => {
    const userId = req.params.userId;

    const getUserPostsQuery = 'SELECT * FROM publicacion WHERE id_autor = ?';

    db.query(getUserPostsQuery, [userId], (err, results) => {
        if (err) {
            console.error('Error al obtener las publicaciones del usuario:', err);
            return res.status(500).send('Error al obtener las publicaciones del usuario');
        }

        // Convertir las imágenes a base64
        const publicaciones = results.map(pub => {
            const fotopost = pub.foto_post ? pub.foto_post.toString('base64') : null;
            return {
                ...pub,
                imageUrl: fotopost ? `data:image/jpeg;base64,${fotopost}` : null
            };
        });

        res.json(publicaciones);
    });
});
// Ruta para cerrar sesión
app.post('/logout', (req, res) => {
    req.session.destroy((err) => {
        if (err) {
            return res.status(500).send('Error al cerrar sesión');
        }
        res.clearCookie('id_usuario');
        res.send('Sesión cerrada correctamente');
    });
});
//******************************Edición de perfil************************
// Configuración de multer para manejar la carga de archivos
app.put("/actualizarPerfil", verificarSesion, upload.single('foto'), (req, res) => {
    const userId = req.session.userId;
    const { nickname, desc, nombre, contrasenia } = req.body;
    const foto = req.file ? req.file.buffer : null;

    console.log("Datos recibidos:", req.body); // Verifica los datos recibidos
    console.log("Contraseña recibida:", contrasenia);

    if (userId) {
        // Verificar si el nickname ya existe para otro usuario
        db.query("SELECT id_usuario FROM usuario WHERE nickname_usuario = ? AND id_usuario != ?", [nickname, userId], (err, result) => {
            if (err) {
                return res.status(500).send("Error al verificar el nickname");
            }
            if (result.length > 0) {
                return res.status(400).send("El nickname ya está en uso por otro usuario");
            }

            // Construir la consulta de actualización de manera dinámica
            let query = "UPDATE usuario SET nickname_usuario = ?, desc_usuario = ?, nombre_usuario = ?";
            const params = [nickname, desc, nombre];

            if (contrasenia) {
                query += ", contrasenia_usuario = ?";
                params.push(contrasenia);
            }

            if (foto) {
                query += ", foto_usuario = ?";
                params.push(foto);
            }

            query += " WHERE id_usuario = ?";
            params.push(userId);

            // Si no hay conflictos, proceder con la actualización
            db.query(query, params, (err, result) => {
                if (err) {
                    return res.status(500).send("Error al actualizar la información del usuario");
                }
                res.status(200).send("Perfil actualizado exitosamente");
            });
        });
    } else {
        res.status(401).send("Usuario no autenticado.");
    }
});

//***************************************************************************************
//***************************************************************************************
//***************************************************************************************



//****************************** Estadistícas ************************
// Ruta para obtener estadísticas de publicaciones/likes por día de la semana
app.get('/stats/publicacionesLikes', verificarSesion, (req, res) => {
    const userId = req.session.userId;
    const query = 'CALL getpublicacionesLikes(?)';

    db.query(query, [userId], (err, results) => {
        if (err) {
            console.error('Error al obtener estadísticas de publicaciones/likes:', err);
            return res.status(500).send('Error al obtener estadísticas de publicaciones/likes');
        }
        res.json(results[0]);
    });
});

// Ruta para obtener estadísticas de interacciones semanales
app.get('/stats/interaccionesSemanales', verificarSesion, (req, res) => {
    const userId = req.session.userId;
    const query = 'CALL getInteraccionesSemanales(?)';

    db.query(query, [userId], (err, results) => {
        if (err) {
            console.error('Error al obtener estadísticas de interacciones semanales:', err);
            return res.status(500).send('Error al obtener estadísticas de interacciones semanales');
        }
        res.json(results[0]);
    });
});

// Ruta para obtener estadísticas de seguidores mensuales
app.get('/stats/seguidoresMensuales', verificarSesion, (req, res) => {
    const userId = req.session.userId;
    const query = 'CALL getSeguidoresMensuales(?)';

    db.query(query, [userId], (err, results) => {
        if (err) {
            console.error('Error al obtener estadísticas de seguidores mensuales:', err);
            return res.status(500).send('Error al obtener estadísticas de seguidores mensuales');
        }
        res.json(results[0]);
    });
});
//***************************************************************************************
//***************************************************************************************
//***************************************************************************************




//****************************** Acciones para las posts del perfil  ************************
// Ruta para borrar una postcación usando un procedimiento almacenado
app.delete('/deletePost/:postId', verificarSesion, (req, res) => {
    const { postId } = req.params;

    const deletePostProcedure = 'CALL borrarposts_byid(?)';

    db.query(deletePostProcedure, [postId], (err, result) => {
        if (err) {
            console.error('Error al borrar la postcación:', err);
            return res.status(500).send('Error al borrar la postcación');
        }

        res.status(200).send('postcación borrada exitosamente');
    });
});
//Ruta para obtener la info de la postcación para editar
app.get('/publicacionEdit/:postId', (req, res) => {
    const { postId } = req.params;

    const getPostQuery = 'SELECT * FROM publicacion WHERE id_post = ?';
    const getCategoriesQuery = 'SELECT id_cat FROM post_cat WHERE id_post = ?';

    db.query(getPostQuery, [postId], (err, postResult) => {
        if (err) {
            console.error('Error al obtener la postcación:', err);
            return res.status(500).send('Error al obtener la postcación');
        }

        if (postResult.length > 0) {
            const post = postResult[0];
            const fotopost = post.foto_post ? post.foto_post.toString('base64') : null;
            const postDetails = {
                ...post,
                imageUrl: fotopost ? `data:image/jpeg;base64,${fotopost}` : null
            };

            db.query(getCategoriesQuery, [postId], (err, categoriesResult) => {
                if (err) {
                    console.error('Error al obtener las categorías:', err);
                    return res.status(500).send('Error al obtener las categorías');
                }

                const categories = categoriesResult.map(row => row.id_cat);
                postDetails.categories = categories;
                res.json(postDetails);
            });
        } else {
            res.status(404).send('postcación no encontrada');
        }
    });
});
// Ruta para actualizar una postcación existente
app.put('/updatePost/:postId', verificarSesion, upload.single('image'), (req, res) => {
    const { postId } = req.params;
    const { title, description, categories } = req.body;
    const image = req.file ? req.file.buffer : null;

    if (!title || !description || !categories) {
        return res.status(400).send('Faltan datos requeridos');
    }

    let updatePostQuery;
    const queryParams = [title, description, postId];

    if (image) {
        updatePostQuery = 'UPDATE publicacion SET titulo_post = ?, desc_post = ?, foto_post = ? WHERE id_post = ?';
        queryParams.splice(2, 0, image); // Insertar la imagen en la posición correcta en queryParams
    } else {
        updatePostQuery = 'UPDATE publicacion SET titulo_post = ?, desc_post = ? WHERE id_post = ?';
    }

    const deleteCategoriesQuery = 'DELETE FROM post_cat WHERE id_post = ?';
    const addCategoryQuery = 'INSERT INTO post_cat (id_post, id_cat) VALUES (?, ?)';

    db.beginTransaction(err => {
        if (err) {
            console.error('Error al iniciar la transacción:', err);
            return res.status(500).send('Error al iniciar la transacción');
        }

        db.query(updatePostQuery, queryParams, (err, result) => {
            if (err) {
                console.error('Error al actualizar la postcación:', err);
                return db.rollback(() => {
                    res.status(500).send('Error al actualizar la postcación');
                });
            }

            db.query(deleteCategoriesQuery, [postId], (err) => {
                if (err) {
                    console.error('Error al eliminar las categorías:', err);
                    return db.rollback(() => {
                        res.status(500).send('Error al eliminar las categorías');
                    });
                }

                const categoryIds = JSON.parse(categories);
                const categoryPromises = categoryIds.map(categoryId => {
                    return new Promise((resolve, reject) => {
                        db.query(addCategoryQuery, [postId, categoryId], (err) => {
                            if (err) {
                                reject(err);
                            } else {
                                resolve();
                            }
                        });
                    });
                });

                Promise.all(categoryPromises)
                    .then(() => {
                        db.commit(err => {
                            if (err) {
                                console.error('Error al confirmar la transacción:', err);
                                return db.rollback(() => {
                                    res.status(500).send('Error al confirmar la transacción');
                                });
                            }

                            res.status(200).send('postcación actualizada exitosamente');
                        });
                    })
                    .catch(err => {
                        console.error('Error al agregar categorías:', err);
                        db.rollback(() => {
                            res.status(500).send('Error al agregar categorías');
                        });
                    });
            });
        });
    });
});
//***************************************************************************************
//***************************************************************************************
//***************************************************************************************





//****************************** Ventana de postcación ************************
//Obtener info para la ventana de publicacion
app.get('/publicacion/:id_post', (req, res) => {
    const { id_post } = req.params;

    const publicacionQuery = 'CALL getpublicacion(?)';
    const comentariosQuery = 'CALL getComentarios(?)';
    const categoriasQuery = 'CALL getCategorias(?)';
    const recomendacionesQuery = 'CALL getRecomendaciones(?)';
    const recientesQuery = 'CALL getRecientesAutor(?)';

    db.query(publicacionQuery, [id_post], (err, publicacionResult) => {
        if (err) return res.status(500).send('Error al obtener la postcación');
        if (publicacionResult[0].length === 0) return res.status(404).send('postcación no encontrada');

        const publicacion = publicacionResult[0][0];
        //console.log(publicacion.id_autor);
        const fotopost = publicacion.foto_post ? publicacion.foto_post.toString('base64') : null;
        const fotoAutor = publicacion.foto_usuario ? publicacion.foto_usuario.toString('base64') : null;
        publicacion.imageUrl = fotopost ? `data:image/jpeg;base64,${fotopost}` : null;
        publicacion.autorPfp = fotoAutor ? `data:image/jpeg;base64,${fotoAutor}` : null;

        db.query(comentariosQuery, [id_post], (err, comentariosResult) => {
            if (err) return res.status(500).send('Error al obtener los comentarios');
            publicacion.comentarios = comentariosResult[0].map(comentario => {
                const comentarioFoto = comentario.foto_usuario ? comentario.foto_usuario.toString('base64') : null;
                return {
                    id_comentario: comentario.id_comm,
                    username: comentario.username,
                    text: comentario.desc_comm,
                    pfp: comentarioFoto ? `data:image/jpeg;base64,${comentarioFoto}` : null
                };
            });

            db.query(categoriasQuery, [id_post], (err, categoriasResult) => {
                if (err) return res.status(500).send('Error al obtener las categorías');
                publicacion.categorias = categoriasResult[0].map(cat => cat.title_cat);

                db.query(recomendacionesQuery, [id_post], (err, recomendacionesResult) => {
                    if (err) return res.status(500).send('Error al obtener las recomendaciones');
                    publicacion.recomendaciones = recomendacionesResult[0].map(rec => {
                        const recFoto = rec.foto_post ? rec.foto_post.toString('base64') : null;
                        return {
                            id: rec.id_post,
                            imageUrl: recFoto ? `data:image/jpeg;base64,${recFoto}` : null
                        };
                    });

                    db.query(recientesQuery, [id_post], (err, recientesResult) => {
                        if (err) return res.status(500).send('Error al obtener las publicaciones recientes');
                        publicacion.recientes = recientesResult[0].map(rec => {
                            const recFoto = rec.foto_post ? rec.foto_post.toString('base64') : null;
                            return {
                                id: rec.id_post,
                                imageUrl: recFoto ? `data:image/jpeg;base64,${recFoto}` : null
                            };
                        });

                        res.json(publicacion);
                    });
                });
            });
        });
    });
});
//Subir comms
app.post('/addComm', verificarSesion, (req, res) => {
    const { id_post, commentText } = req.body;
    const userId = req.session.userId;

    console.log('req.body:', req.body);
    console.log('userId:', userId);

    if (!id_post || !commentText) {
        return res.status(400).send('Faltan datos requeridos');
    }

    const agregarComentarioQuery = 'INSERT INTO comentario (id_usuario, desc_comm) VALUES (?, ?)';
    const conectarComentarioQuery = 'INSERT INTO post_comm (id_post, id_comm) VALUES (?, ?)';

    db.beginTransaction(err => {
        if (err) {
            console.error('Error al iniciar la transacción:', err);
            return res.status(500).send('Error al iniciar la transacción');
        }

        db.query(agregarComentarioQuery, [userId, commentText], (err, result) => {
            if (err) {
                console.error('Error al agregar el comentario:', err);
                return db.rollback(() => {
                    res.status(500).send('Error al agregar el comentario');
                });
            }

            const id_comentario = result.insertId;

            db.query(conectarComentarioQuery, [id_post, id_comentario], (err) => {
                if (err) {
                    console.error('Error al conectar el comentario con la postcación:', err);
                    return db.rollback(() => {
                        res.status(500).send('Error al conectar el comentario con la postcación');
                    });
                }

                db.commit(err => {
                    if (err) {
                        console.error('Error al confirmar la transacción:', err);
                        return db.rollback(() => {
                            res.status(500).send('Error al confirmar la transacción');
                        });
                    }

                    res.status(201).send('Comentario agregado exitosamente');
                });
            });
        });
    });
});

// Ruta para seguir a un autor
app.post('/follow', verificarSesion, (req, res) => {
    const { authorId } = req.body;
    const userId = req.session.userId;

    const followQuery = 'INSERT INTO follow (id_usuario, id_ufollowed, fecha_follow ) VALUES (?, ?, NOW() )';

    db.query(followQuery, [userId, authorId], (err, result) => {
        if (err) {
            console.error('Error al seguir al autor:', err);
            return res.status(500).send('Error al seguir al autor');
        }
        res.status(200).send('Autor seguido exitosamente');
    });
});
// Ruta para dejar de seguir a un autor
app.post('/unfollow', verificarSesion, (req, res) => {
    const { authorId } = req.body;
    const userId = req.session.userId;

    const unfollowQuery = 'DELETE FROM follow WHERE id_usuario = ? AND id_ufollowed = ?';

    db.query(unfollowQuery, [userId, authorId], (err, result) => {
        if (err) {
            console.error('Error al dejar de seguir al autor:', err);
            return res.status(500).send('Error al dejar de seguir al autor');
        }
        res.status(200).send('Autor dejado de seguir exitosamente');
    });
});
// Ruta para verificar si el usuario sigue a un autor
app.get('/isFollowing/:authorId', verificarSesion, (req, res) => {
    const userId = req.session.userId;
    const { authorId } = req.params;

    const isFollowingQuery = 'SELECT * FROM follow WHERE id_usuario = ? AND id_ufollowed = ?';

    db.query(isFollowingQuery, [userId, authorId], (err, result) => {
        if (err) {
            console.error('Error al verificar si el usuario sigue al autor:', err);
            return res.status(500).send('Error al verificar seguimiento');
        }
        res.status(200).send(result.length > 0);
    });
});


// Ruta para obtener el número de likes de una postcación
app.get('/likes/:postId', (req, res) => {
    const { postId } = req.params;

    const getLikesQuery = 'SELECT COUNT(*) AS likes FROM likes WHERE id_post = ?';

    db.query(getLikesQuery, [postId], (err, results) => {
        if (err) {
            console.error('Error al obtener los likes:', err);
            return res.status(500).send('Error al obtener los likes');
        }

        res.json({ likes: results[0].likes });
    });
});
// Ruta para agregar un like a una postcación
app.post('/like', verificarSesion, (req, res) => {
    const { postId } = req.body;
    const userId = req.session.userId;

    // Verificar si el usuario ya ha dado like
    const checkLikeQuery = 'SELECT * FROM likes WHERE id_post = ? AND id_usuario = ?';

    db.query(checkLikeQuery, [postId, userId], (err, results) => {
        if (err) {
            console.error('Error al verificar el like:', err);
            return res.status(500).send('Error al verificar el like');
        }

        if (results.length > 0) {
            return res.status(400).send('Ya has dado like a esta postcación');
        } else {
            const addLikeQuery = 'INSERT INTO likes (id_post, id_usuario, fecha_like) VALUES (?, ?, NOW())';

            db.query(addLikeQuery, [postId, userId], (err, result) => {
                if (err) {
                    console.error('Error al agregar el like:', err);
                    return res.status(500).send('Error al agregar el like');
                }

                res.status(200).send('Like agregado exitosamente');
            });
        }
    });
});
// Ruta para quitar un like de una postcación (opcional)
app.post('/unlike', verificarSesion, (req, res) => {
    const { postId } = req.body;
    const userId = req.session.userId;

    const removeLikeQuery = 'DELETE FROM likes WHERE id_post = ? AND id_usuario = ?';

    db.query(removeLikeQuery, [postId, userId], (err, result) => {
        if (err) {
            console.error('Error al quitar el like:', err);
            return res.status(500).send('Error al quitar el like');
        }

        res.status(200).send('Like quitado exitosamente');
    });
});
// Ruta para verificar si el usuario ha dado like a una postcación
app.get('/isLiked/:postId', verificarSesion, (req, res) => {
    const userId = req.session.userId;
    const { postId } = req.params;

    const isLikedQuery = 'SELECT * FROM likes WHERE id_post = ? AND id_usuario = ?';

    db.query(isLikedQuery, [postId, userId], (err, results) => {
        if (err) {
            console.error('Error al verificar si el usuario ha dado like:', err);
            return res.status(500).send('Error al verificar si el usuario ha dado like');
        }

        res.status(200).send(results.length > 0);
    });
});


//Subir post
app.post('/addPost', verificarSesion, upload.single('image'), (req, res) => {
    const { title, description, categories } = req.body;
    const userId = req.session.userId;
    const image = req.file ? req.file.buffer : null;

    if (!title || !description || !categories || !image) {
        return res.status(400).send('Faltan datos requeridos');
    }

    const addPostQuery = 'INSERT INTO publicacion (id_autor, titulo_post, desc_post, foto_post, fecha_post) VALUES (?, ?, ?, ?, NOW())';
    const addCategoryQuery = 'INSERT INTO post_cat (id_post, id_cat) VALUES (?, ?)';

    db.beginTransaction(err => {
        if (err) {
            console.error('Error al iniciar la transacción:', err);
            return res.status(500).send('Error al iniciar la transacción');
        }

        db.query(addPostQuery, [userId, title, description, image], (err, result) => {
            if (err) {
                console.error('Error al agregar la postcación:', err);
                return db.rollback(() => {
                    res.status(500).send('Error al agregar la postcación');
                });
            }

            const postId = result.insertId;
            const categoryIds = JSON.parse(categories);

            const categoryPromises = categoryIds.map(categoryId => {
                return new Promise((resolve, reject) => {
                    db.query(addCategoryQuery, [postId, categoryId], (err) => {
                        if (err) {
                            reject(err);
                        } else {
                            resolve();
                        }
                    });
                });
            });

            Promise.all(categoryPromises)
                .then(() => {
                    db.commit(err => {
                        if (err) {
                            console.error('Error al confirmar la transacción:', err);
                            return db.rollback(() => {
                                res.status(500).send('Error al confirmar la transacción');
                            });
                        }

                        res.status(201).send('postcación agregada exitosamente');
                    });
                })
                .catch(err => {
                    console.error('Error al agregar categorías:', err);
                    db.rollback(() => {
                        res.status(500).send('Error al agregar categorías');
                    });
                });
        });
    });
});
//Obtener categorías
app.get('/categorias', (req, res) => {
    const getCategoriasQuery = 'SELECT id_cat, title_cat FROM categoria';

    db.query(getCategoriasQuery, (err, results) => {
        if (err) {
            console.error('Error al obtener las categorías:', err);
            return res.status(500).send('Error al obtener las categorías');
        }

        if (results.length > 0) {
            const categorias = results.map(row => ({
                id: row.id_cat,
                name: row.title_cat
            }));
            res.json(categorias);
        } else {
            res.status(404).send('No se encontraron categorías');
        }
    });
});
//***************************************************************************************
//***************************************************************************************
//***************************************************************************************


//******************************DashBoard ************************
app.get("/getnewtoold",
    (req, resp) => {
        db.query("CALL posts_newtoold",
            (error, data) => {
                if (error) {
                    resp.send(error);
                } else {
                    if (data.length > 0) {
                        resp.json(data);
                    } else {
                        resp.json('No imagen');
                    }
                }
            })
    });

app.get("/getufollowed", verificarSesion, (req, resp) => {
    const userId = req.session.userId; // Usar el ID del usuario desde la sesión
    if (userId) {
        db.query("CALL posts_ufollowed(?)", [userId], (error, data) => {
            if (error) {
                resp.status(500).send(error);
            } else if (data.length > 0) {
                resp.json(data);
            } else {
                resp.json('No imagen');
            }
        });
    } else {
        resp.status(401).send("No autorizado");
    }
});
//***************************************************************************************
//***************************************************************************************
//***************************************************************************************


//******************************Lógica de carga de imágenes************************
app.post("/file", upload.single('file'),
    (req, resp) => {
        const imagenB64 = req.file.buffer;
        const usName = req.body.user;

        db.query("INSERT INTO usuario(nickname_usuario, foto_usuario) VALUES(?,?)",
            [usName, imagenB64],
            (err, data) => {
                if (err) {
                    resp.json({
                        "alert": 'Error'
                    })
                } else {
                    resp.json({
                        "alert": 'Success'
                    })
                }
            })
        console.log(imagenB64, usName);
    })
app.get("/getAllImg",
    (req, resp) => {
        db.query("SELECT * FROM usuario",
            (error, data) => {
                if (error) {
                    resp.send(error);
                } else {
                    if (data.length > 0) {
                        resp.json(data);
                    } else {
                        resp.json('No imagen');
                    }
                }
            })
    })
//***************************************************************************************
//***************************************************************************************
//***************************************************************************************
//Referencia de elminado de "usuarios.js"
app.delete("/delete/:nomUser",
    (req, resp) => {
        const nombreU = req.params.nomUser;

        db.query('DELETE FROM usuarios WHERE name=?',
            nombreU,
            (error, data) => {
                if (error) {
                    console.log(error);
                } else {
                    resp.send("Empleado eliminado");
                }
            })
    }


)
//Obtener usuarios *solo para referencias*
app.get("/getU",
    (req, resp) => {
        db.query('SELECT * FROM usuario',
            (error, data) => {
                if (error) {
                    console.log(error);
                } else {
                    resp.send(data);
                }
            })
    }
)