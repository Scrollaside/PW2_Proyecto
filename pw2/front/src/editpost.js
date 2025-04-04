import 'bootstrap/dist/css/bootstrap.css';
import 'bootstrap/dist/js/bootstrap.bundle.js';
import Swal from 'sweetalert2';
import styles from './paginaWeb/css/createpost.module.css';
import React, { useState, useEffect, useRef } from 'react';
import axiosInstance from './AxiosConf/axiosconf';
import { Link, useNavigate, useParams } from 'react-router-dom';

//Componentes
import Menu from './components/menuComponent';
import { usePerfil } from './components/publicacionUtils';

function Editpost() {
    const nav = useNavigate();
    const { postId } = useParams();
    const perfil = usePerfil(); 
    const [imageFile, setImageFile] = useState(null);
    const [title, setTitle] = useState('');
    const [description, setDescription] = useState('');
    const [categories, setCategories] = useState({});
    const [categoryOptions, setCategoryOptions] = useState([]);
    const [errors, setErrors] = useState({ title: '', description: '', categories: '', image: '' });
    const imgElementRef = useRef(null);

    useEffect(() => {   
        axiosInstance.get(`/categorias`)
            .then(response => {
                const options = response.data.map(category => ({
                    id: category.id,
                    name: category.name
                }));
                setCategoryOptions(options);
            })
            .catch(error => {
                console.error("Error al obtener las categorías:", error);
            });

        axiosInstance.get(`/publicacionEdit/${postId}`)
            .then(response => {
                const post = response.data;
                setTitle(post.titulo_post);
                setDescription(post.desc_post);
                const initialCategories = response.data.categories.reduce((acc, categoryId) => {
                    acc[categoryId] = true;
                    return acc;
                }, {});
                setCategories(initialCategories);
                if (post.imageUrl) {
                    imgElementRef.current.src = post.imageUrl;
                }
            })
            .catch(error => {
                console.error("Error al obtener los datos de la postcación:", error);
            });
    }, [postId]);

    const handleFileChange = (event) => {
        const file = event.target.files[0];
        setImageFile(file);
        if (file) {
            const imgUrl = URL.createObjectURL(file);
            imgElementRef.current.src = imgUrl;
        }
    };

    const handleCategoryChange = (categoryId) => {
        const selectedCategories = Object.values(categories).filter(value => value).length;

        if (!categories[categoryId] && selectedCategories >= 3) {
            Swal.fire({
                title: 'Límite alcanzado',
                text: 'Solo puedes seleccionar hasta 3 categorías.',
                icon: 'warning',
                confirmButtonText: 'OK'
            });
            return;
        }

        setCategories(prevCategories => ({
            ...prevCategories,
            [categoryId]: !prevCategories[categoryId]
        }));
    };

    const validatePost = () => {
        const errors = {};
        if (!title.trim()) {
            errors.title = 'El título es requerido.';
        }
        if (!description.trim()) {
            errors.description = 'La descripción es requerida.';
        }
        if (!Object.values(categories).some(value => value)) {
            errors.categories = 'Debes seleccionar al menos una categoría.';
        }

        if (Object.keys(errors).length > 0) {
            setErrors(errors);
            return false;
        } else {
            const formData = new FormData();
            formData.append('title', title);
            formData.append('description', description);
            formData.append('categories', JSON.stringify(Object.keys(categories).filter(key => categories[key])));
            if (imageFile) {
                formData.append('image', imageFile);
            }

            axiosInstance.put(`/updatePost/${postId}`, formData, {
                headers: {
                    'Content-Type': 'multipart/form-data'
                }
            })
            .then(response => {
                Swal.fire({
                    title: 'Tu postcación se actualizó con éxito',
                    text: '<3',
                    icon: 'success',
                    confirmButtonText: 'Yeiiiiii :DD'
                }).then((result) => {
                    if (result.isConfirmed) {
                        nav("/dashboard");
                    }
                });
            })
            .catch(error => {
                console.error("Error al actualizar la postcación:", error);
                Swal.fire({
                    title: 'Error',
                    text: 'Hubo un problema al actualizar la postcación.',
                    icon: 'error',
                    confirmButtonText: 'OK'
                });
            });
            return true;
        }
    };

    return (
        <>
            <Menu perfil={perfil} />

            <div className="container">
                <div className={`${styles.row} row`}>
                    <div className="col-md-4">
                        <div id={styles.carouselExample} className="carousel slide" data-bs-ride="carousel">
                            <div className="carousel-inner" id="carouselInner">
                                <img ref={imgElementRef} className="d-block w-100 carousel-item" alt="Preview" />
                            </div>
                        </div>
                        <label htmlFor="BotonSubirFoto" className={`${styles.customfileupload} custom-file-upload`}>Subir foto</label>
                        <input type="file" accept="image/*" id="BotonSubirFoto" style={{ marginTop: '10px' }} onChange={handleFileChange} hidden />
                        <span id="imageError" className={`${styles.error} error-message`}>{errors.image}</span>
                    </div>

                    <div id={styles.postInfo} className="col-md-8">
                        <input type="text" id="titleP" className={styles.titleP} placeholder="Nuevo Título" style={{ marginBottom: '10px' }} value={title} onChange={(e) => setTitle(e.target.value)} />
                        <span id="titleError" className={`${styles.error} error-message`}>{errors.title}</span>
                        <br />
                        <input type="text" id="descP" className={`${styles.descP} error-message`} placeholder="Nueva Descripción" style={{ marginBottom: '10px' }} value={description} onChange={(e) => setDescription(e.target.value)} />
                        <span id="descError" className={`${styles.error} error-message`}>{errors.description}</span>
                        <br />
                        <div id="catP" className={`${styles.catP} col-md-8`} style={{ marginBottom: '10px' }}>
                            {categoryOptions.map(category => (
                                <div key={category.id} className="form-check form-check-inline categoria">
                                    <input 
                                        className={`${styles.formcheckinput} form-check-input`} 
                                        type="checkbox" 
                                        id={`category-${category.id}`}
                                        checked={categories[category.id] || false} 
                                        onChange={() => handleCategoryChange(category.id)} 
                                    />
                                    <label className={`${styles.formchecklabel} form-check-label checkbox-label`} htmlFor={`category-${category.id}`}>{category.name}</label>
                                </div>
                            ))}
                            <span id="catError" className={`${styles.error} error-message`}>{errors.categories}</span>
                        </div>
                        <button id={styles.BotonPostear} onClick={validatePost} style={{ marginTop: '10px' }}>Actualizar</button>
                    </div>
                </div>
            </div>
        </>
    );
}

export default Editpost;
