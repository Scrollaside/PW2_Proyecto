import React, { useState } from 'react'
import 'bootstrap/dist/css/bootstrap.css';
import Axios from 'axios';

function Usuarios() {
    const[userList, setUList] = useState([]);

    const get = () =>{
        Axios.get("https://pw2-proyecto.onrender.com/getU",{
        }).then((resp)=>{
            setUList(resp.data);
        })
    }

    const del = (nomUD) =>{
        Axios.delete(`https://pw2-proyecto.onrender.com/delete/${nomUD}`,{
        }).then(()=>{
            alert("informaión enviada");
        })
    }

  return (
    <>
    <button className="btn btn-primary" onClick={get}>Mostrar usuarios</button>
    
    {
        userList.map((val, key)=>{
            return(
        <div className='card'>
            <div className='card-body'>
                <h5 className='card-title'>{val.nickname_usuario}</h5>
                <p className='card-text'>{val.email_usuario}</p>
            </div>
            <div>
                <button className='btn btn-danger' onClick={()=>{del(val.name)}}>Eliminar</button>
            </div>
        </div>
            )
        })
    }
    
    
    </>
  )
}

export default Usuarios