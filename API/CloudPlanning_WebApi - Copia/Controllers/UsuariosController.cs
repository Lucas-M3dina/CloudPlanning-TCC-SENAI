﻿
using CloudPlanning_WebApi.Domains;
using CloudPlanning_WebApi.Interfaces;
using CloudPlanning_WebApi.Utils;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;

namespace CloudPlanning_WebApi.Controllers
{
    // Define que o tipo de resposta da API será no formato JSON
    [Produces("application/json")]

    [Route("api/[controller]")]
    [ApiController]
    public class UsuariosController : ControllerBase
    {
        Email e = new();
        private readonly IUsuarioRepository _usuarioRepository;

        public UsuariosController(IUsuarioRepository contexto)
        {
            _usuarioRepository = contexto;
        }

        [HttpGet]
        public IActionResult Get()
        {
            return Ok(_usuarioRepository.Listar());
        }

        [HttpPost]
        public IActionResult Post(UsuarioComum user)
        {
            try
            {
                _usuarioRepository.Cadastrar(user);
                e.SendEmail(user.IdUsuarioNavigation.Email);

                return Created("Usuario Cadastrado", new { id = user.IdUsuario });
            }
            catch (Exception erro)
            {
                return BadRequest(erro);
            }
        }
    }
}
