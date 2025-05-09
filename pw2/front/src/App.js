import 'bootstrap/dist/css/bootstrap.css';
//import './App.css';
import { BrowserRouter, Route, Routes } from 'react-router-dom';
import { useState } from 'react';
import Axios from 'axios';
//import de páginas
import Registro from './Registro';
import Dashboard from './Dashboard';
import Explorar from './Explorar';
import InicioSesion from './is';
import Perfil from './perfil';
import Publicacion from './publicacion';
import Editperfil from './editPerfil';
import Stats from './stats';
import Editpost from './editpost';
import CreatePost from './createPost';

import Usuarios from './Usuarios';
import CargarImagen from './CargarImage';

function App() {

  return (
    <BrowserRouter>
      <Routes>
        <Route path='/' element={<InicioSesion />}></Route>
        <Route path='/registro' element={<Registro />}></Route>

        <Route path='/dashboard' element={<Dashboard />}></Route>
        <Route path='/explorar' element={<Explorar />}></Route>

        {/* <Route path='/perfil' element={<Perfil />}></Route> */}
        <Route path='/perfil/:userId' element={<Perfil />}></Route>

        {/* <Route path='/publicacion' element={<Publicacion />}></Route> */}
        <Route path='/publicacion/:id_post' element={<Publicacion />}></Route> {/* Ruta actualizada */}

        <Route path='/editperfil' element={<Editperfil />}></Route>

        <Route path='/stats' element={<Stats />}></Route>
        <Route path='/stats/publicacionesLikes' element={<Stats option="publicacionesLikes" />} />
        <Route path='/stats/interaccionesSemanales' element={<Stats option="interaccionesSemanales" />} />
        <Route path='/stats/seguidoresMensuales' element={<Stats option="seguidoresMensuales" />} />


        {/* <Route path='/editpost' element={<Editpost />}></Route> */}
        <Route path='/editpost/:postId' element={<Editpost />}></Route>
        <Route path='/crearpost' element={<CreatePost />}></Route>

        <Route path='/usuarios' element={<Usuarios />}></Route>
        <Route path='/cargarimagen' element={<CargarImagen />}></Route>

      </Routes>
    </BrowserRouter>
  );
}



export default App;