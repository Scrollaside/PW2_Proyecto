// axiosconf.js
import axios from 'axios';

const axiosInstance = axios.create({
    // baseURL: 'http://localhost:3001',
    baseURL: 'https://pw2-proyecto.onrender.com',
    withCredentials: true // importante para las cookies de sesión
});

export default axiosInstance;

