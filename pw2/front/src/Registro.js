import 'bootstrap/dist/css/bootstrap.css';
import styles from './paginaWeb/css/register.module.css';
import Swal from 'sweetalert2';
import { Link, useNavigate } from 'react-router-dom';
import { useState, useEffect } from 'react';
import axiosInstance from './AxiosConf/axiosconf';


function validationCampos(name, nickN, mail, pass, pass2, setNameError, setNickError, setMailError, setPassError, setPass2Error) {
  let isValid = true;

  // Perform validation
  if (name.trim() === '') {
    setNameError('Por favor, complete este campo.');
    isValid = false;
  }
  if (nickN.trim() === "") {
    setNickError('Por favor, complete este campo.');
    isValid = false;
  }
  if (mail.trim() === "") {
    setMailError('Por favor, complete este campo.');
    isValid = false;
  }
  if (pass.trim() === "") {
    setPassError('Por favor, complete este campo.');
    isValid = false;

  } else if (pass.length < 8 || !/[A-Z]/.test(pass) || !/\d/.test(pass)) {
    setPassError('La contraseña debe tener al menos 8 caracteres, una mayúscula y un número. ');
    isValid = false;
  }
  if (pass2.trim() === "") {
    setPass2Error('Por favor, complete este campo.');
    isValid = false;
  }
  if (pass !== pass2) {
    setPass2Error('Las contraseñas no coinciden.');
    isValid = false;
  }

  if (isValid === true) {
    return true
  }
  else {
    return false
  }

}

const Registro = () => {

  const nav = useNavigate();
  //Si ya existe un usuario con sesión
  useEffect(() => {
    const verificarSesion = async () => {
      try {
        const response = await axiosInstance.get('/perfilMenu');
        if (response.status === 200) {
          nav('/dashboard');
        }
      } catch (error) {
        //console.error('No hay sesión activa:', error);
      }
    };

    verificarSesion();
  }, [nav]);

  const [name, setName] = useState('');
  const [nickN, setNickN] = useState('');
  const [mail, setMail] = useState('');
  const [pass, setPass] = useState('');
  const [pass2, setPass2] = useState('');
  const [nameError, setNameError] = useState('');
  const [nickError, setNickError] = useState('');
  const [mailError, setMailError] = useState('');
  const [passError, setPassError] = useState('');
  const [pass2Error, setPass2Error] = useState('');



  const handleSubmit = async (e) => {
    e.preventDefault();

    // Reset errors
    setNameError('');
    setNickError('');
    setMailError('');
    setPassError('');
    setPass2Error('');

    // Validar campos
    const isValid = validationCampos(name, nickN, mail, pass, pass2, setNameError, setNickError, setMailError, setPassError, setPass2Error);

    if (!isValid) {
      // Si la validación no pasa, no continúes con el envío del formulario
      return;
    }

    try {
      // https://front.webart.infinityfreeapp.com
      const response = await axiosInstance.post('/create', {
        usuario: name,
        apodo: nickN, // Agregar el apodo (nickname) al objeto enviado al servidor
        correo: mail,
        contra: pass
      });
      console.log(response.data);
      //Alerta               
      Swal.fire(
        'Bienvenido a WEBART ' + name + '!',
        'Gracias por unirte a WebArt',
        'success'
      ).then((result) => {
        if (result.isConfirmed) {
          // Redirigir al usuario a la página "/dashboard"
          nav("/dashboard");
        }
      });


    } catch (error) {
      console.error(error);
      Swal.fire('Error al registrar el usuario',
        ':C',
        'error'
      );
    }
  };


  return (
    <>

      <div className={styles["register-container"]}>
        <h3 className="text-white" align="center">Registrate!</h3>

        <form onSubmit={handleSubmit}>

          <label htmlFor="name">Nombre:</label><br />
          <input id="name" type="text" value={name} onChange={(e) => setName(e.target.value)} />
          <span id="nameError" className={`${styles.error} error`}>{nameError}</span>
          <br />



          <label htmlFor="nickN">Apodo:</label><br />
          <input id="nickN" type="text" value={nickN} onChange={(e) => setNickN(e.target.value)} />
          <span id="nickError" className={`${styles.error} error`}>{nickError}</span>
          <br />


          <label htmlFor="mail">Correo:</label><br />
          <input id="mail" type="email" value={mail} onChange={(e) => setMail(e.target.value)} />
          <span id="mailError" className={`${styles.error} error`}>{mailError}</span>
          <br />


          <label htmlFor="pass">Contraseña:</label><br />
          <input id="pass" type="password" value={pass} onChange={(e) => setPass(e.target.value)} />
          <span id="passError" className={`${styles.error} error`}>{passError}</span>
          <br />


          <label htmlFor="pass2">Confirmar Contraseña:</label><br />
          <input id="pass2" type="password" value={pass2} onChange={(e) => setPass2(e.target.value)} />
          <span id="pass2Error" className={`${styles.error} error`}>{pass2Error}</span>
          <br />


          <button type="submit">Crear</button>
          <p className="text-white">Already have an account?
            <Link to="/">Log In</Link>
          </p>


        </form>
      </div>

      <style>{`
     body {
      /* Eliminamos display:flex y align-items/justify-content */
      /* Ajustamos el margin a 0 */
      margin: 0;
      background-color: #3ea0ca; /* Color de fondo */
      background-image: url('../../resources/Illustrations/Login.png');
      background-position: center;
      background-repeat: no-repeat;
      background-size: cover;

  }

  /* Establecemos un z-index alto para asegurarnos de que la imagen de fondo esté detrás de otras capas */
    body::before {
        content: "";
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        z-index: -1;
        background-color: #3ea0ca; /* Color de fondo */
        background-image: url('../../resources/Illustrations/Login.png');
        background-position: center;
        background-repeat: no-repeat;
        background-size: cover;
    }
    `}</style>

    </>
  );

};

export default Registro;