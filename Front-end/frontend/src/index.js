import React from 'react';
import ReactDOM from 'react-dom';
import {
  Route,
  BrowserRouter as Router,
  Routes,
  Navigate
} from 'react-router-dom';
import { usuarioAutenticado } from './services/auth';
import './index.css';
import Home from './pages/home/App';
import Login from './pages/login/login';
import cadastro from './pages/cadastro/cadastro';
import diagramas from './pages/diagramas/diagramas';
import NotFound from './pages/notFound/NotFound';
import Budge from './pages/budge/budge'

import reportWebVitals from './reportWebVitals';

const routing = (
  <Router>
      <Routes>
        <Route exact path="/" element={<Home/>} /> {/* Home */}
        <Route path="/Login" element={<Login/>} /> {/* Login */}
        <Route path="/cadastro" element={<cadastro/>} /> {/* Cadastro */}

        <Route path="/diagramas" render={props =>
      usuarioAutenticado() ? (
        <diagramas {...props} />
      ) : (
        <Navigate to={{ pathname: "/Login", state: { from: props.location } }} />
      )} /> {/* Diagramas */}

        <Route path="/budge" render={props =>
      usuarioAutenticado() ? (
        <Budge {...props} />
      ) : (
        <Navigate to={{ pathname: "/Login", state: { from: props.location } }} />
      )} /> {/* Budge */}

        <Route path="/notFound" element={<NotFound/>} /> {/* Not Found */}
        <Route path="*" element={<Navigate to="/notFound" />} /> {/* Redireciona para Not Found caso não encontre nenhuma rota */}
      </Routes>
  </Router>
)


ReactDOM.render(
  routing,
  document.getElementById('root')
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();
