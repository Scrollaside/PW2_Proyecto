import axios from 'axios';

const axiosInstance = axios.create({
    // baseURL: 'http://localhost:3001',
    baseURL: 'back.pw2proyect.infinityfreeapp.com',
    withCredentials: true // importante para las cookies de sesión
});

export default axiosInstance;

