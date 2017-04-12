package dao;

import modelo.Usuario;


public interface UserDao {
    Usuario loadUserByUsername(String usuario, String contrasenya);
     
}