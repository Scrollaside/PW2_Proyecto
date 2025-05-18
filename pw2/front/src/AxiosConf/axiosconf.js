// axiosconf.js
import axios from 'axios';

const axiosInstance = axios.create({
    // aseURL: 'http://localhost:3001',
    baseURL: 'https://pw2-proyecto.onrender.com', //comentar esto
    withCredentials: true // importante para las cookies de sesión
});

export default axiosInstance;

