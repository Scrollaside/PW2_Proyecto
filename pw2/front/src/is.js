import 'bootstrap/dist/css/bootstrap.css';
import style from './paginaWeb/css/login.module.css';
import Swal from 'sweetalert2';
import { Link, useNavigate } from 'react-router-dom';
import { useState, useEffect } from 'react';
import axiosInstance from './AxiosConf/axiosconf';

const InicioSesion = () => {
    const nav = useNavigate();
    //Si ya existe un usuario con sesión
    useEffect(() => {
        const verificarSesion = async () => {
            try {
                const response = await axiosInstance.get('/perfilMenu');
                if (response.status === 200) {
                    nav('/Dashboard');
                }
            } catch (error) {
                //console.error('No hay sesión activa:', error);
            }
        };

        verificarSesion();
    }, [nav]);

    const [user, setUser] = useState('');
    const [pass, setPass] = useState('');

    const handleSubmit = async (e) => {
        e.preventDefault();

        try {
            const response = await axiosInstance.post('/login', {
                us: user,
                con: pass
            });

            if (response.data.alert === "Success") {
                Swal.fire(
                    'Bienvenido a WEBART ' + user + '!',
                    'Iniciaste sesión correctamente',
                    'success'
                ).then((result) => {
                    if (result.isConfirmed) {
                        nav("/Dashboard");
                    }
                });
            } else {
                Swal.fire('Usuario no encontrado o contraseña incorrecta', 'error', 'error');
            }
        } catch (error) {
            console.error(error);
            Swal.fire('No pudimos conectarnos al servidor', 'error', 'error');
        }
    };

    return (
        <>
            <div className={style["login-container"]}>
                <h3 className="text-white" align="center">Login!</h3>
                <form onSubmit={handleSubmit}>
                    <input type="text" placeholder="Username" value={user} onChange={(e) => setUser(e.target.value)} required />
                    <input type="password" placeholder="Password" value={pass} onChange={(e) => setPass(e.target.value)} required />
                    <button type="submit">Sign In</button>
                    <p className="text-white">Don't have an account?
                        <Link to="/register">Sign Up</Link>
                    </p>
                </form>
            </div>

            <style>{`
                body {
                    margin: 0;
                    background-color: #080808;
                    background-image: url('/resources/Illustrations/Login.png');
                    background-position: center;
                    background-repeat: no-repeat;
                    background-size: cover;
                }
                
                body::before {
                    content: "";
                    position: fixed;
                    top: 0;
                    left: 0;
                    width: 100%;
                    height: 100%;
                    z-index: -1;
                    background-color: #080808;
                    background-image: url('/resources/Illustrations/Login.png');
                    background-position: center;
                    background-repeat: no-repeat;
                    background-size: cover;
                }
            `}</style>
        </>
    );
};

export default InicioSesion;
