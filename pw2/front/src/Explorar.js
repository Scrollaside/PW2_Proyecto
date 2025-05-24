import 'bootstrap/dist/css/bootstrap.css';
//import styles from './paginaWeb/css/dashboard.module.css';
import React, { useState, useEffect } from 'react';
import Masonry from 'masonry-layout';
//import Axios from 'axios';
import axiosInstance from './AxiosConf/axiosconf';
//import { Link } from 'react-router-dom';

//Componentes
import CardContainer from './components/cardContainerDashboard';
import Menu from './components/menuComponent';
import {usePerfil} from './components/publicacionUtils';


function Explore() {


    const [allImg, setAllImg] = useState([]);
    const [base64Images, setBase64Images] = useState([]);

    const [categorias, setCategorias] = useState([]);
    const [selectedCat, setSelectedCat] = useState(""); // Estado para el filtro de categoría


    const perfil = usePerfil(); 


    //Obtiene valores de las fotos y demás cosas de la base de datos
    useEffect(() => {
        axiosInstance.get("/getnewtoold")
            .then((response) => {
                if (response.data === "No imagen") {
                    alert("No hay imágenes");
                } else {
                    setAllImg(response.data);
                    //console.log(response.data);
                }
            })
            .catch((error) => {
                console.error("Error fetching images:", error);
            });
    }, []);

    // Cargar categorías al montar
    useEffect(() => {
        axiosInstance.get("/categorias")
            .then((response) => {
                setCategorias(response.data);
            })
            .catch((error) => {
                console.error("Error fetching categories:", error);
            });
    }, []);





    //Conversion de los valores a un base64
    useEffect(() => {
        const convertImagesToBase64 = async () => {
            if (allImg.length > 0 && Array.isArray(allImg[0]) && allImg[0].length > 0) {
                const base64Promises = allImg[0].map((val) => {
                    const blob = new Blob([new Uint8Array(val.foto_post.data)], { type: 'image/jpeg' });
                    const reader = new FileReader();
                    reader.readAsDataURL(blob);
                    return new Promise((resolve) => {
                        reader.onloadend = () => {
                            resolve(reader.result.split(',')[1]);
                        };
                    });
                });

                try {
                    const base64Strings = await Promise.all(base64Promises);
                    setBase64Images(base64Strings);
                    //console.log(base64Strings); // Cambiado a log de base64Strings en lugar de base64Images
                } catch (error) {
                    console.error("Error converting images to base64:", error);
                }
            }
        };

        convertImagesToBase64(); // Llamamos a la función de conversión independientemente del tamaño de allImg

    }, [allImg]);
    //Masonry effect    
    useEffect(() => {
        const initializeMasonry = () => {
            const grid = document.querySelector('.row-cols-md-3');
            if (grid) {
                const masonry = new Masonry(grid, {
                    itemSelector: '.col',
                    percentPosition: true
                });
                masonry.layout();
            }
        };

        initializeMasonry();
    }, [allImg]);


const [publicaciones, setPublicaciones] = useState([]);


// Cuando allImg cambia, obtén las categorías de cada publicación
useEffect(() => {
    const fetchPublicacionesConCategorias = async () => {
        if (allImg.length > 0 && Array.isArray(allImg[0])) {
            const publicacionesPromises = allImg[0].map(async (pub) => {
                try {
                    const res = await axiosInstance.get(`/publicacion/${pub.id_post}`);
                    return {
                        ...pub,
                        categorias: res.data.categorias // array de strings
                    };
                } catch (error) {
                    return { ...pub, categorias: [] };
                }
            });
            const pubs = await Promise.all(publicacionesPromises);
            setPublicaciones(pubs);
        }
    };
    fetchPublicacionesConCategorias();
}, [allImg]);

const publicacionesFiltradas = selectedCat
    ? publicaciones.filter(pub => pub.categorias && pub.categorias.includes(selectedCat))
    : publicaciones;

return (
    <>
        <Menu perfil={perfil} />

        {/* Dropdown de categorías */}
        <div className="container my-3">
            <select
                className="form-select"
                value={selectedCat}
                onChange={e => setSelectedCat(e.target.value)}
            >
                <option value="">Todas las categorías</option>
                {categorias.map(cat => (
                    <option key={cat.id} value={cat.name}>{cat.name}</option>
                ))}
            </select>
        </div>

        {/* Renderiza el contenedor de tarjetas con los datos filtrados */}
        <CardContainer data={
            publicacionesFiltradas.map((pub, index) => ({
                imageUrl: base64Images[index],
                title: pub.titulo_post,
                idPost: pub.id_post
            }))
        } />
    </>
);
}

export default Explore