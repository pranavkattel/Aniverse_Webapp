package com.aniverse.service;

import com.aniverse.dao.StudioDAO;
import com.aniverse.model.Studio;

import java.sql.SQLException;
import java.util.List;

public class StudioService {
    private StudioDAO studioDAO;
    
    public StudioService() {
        this.studioDAO = new StudioDAO();
    }
    
    public List<Studio> getAllStudios() throws SQLException, ClassNotFoundException {
        return studioDAO.getAllStudios();
    }
    
    public Studio getStudioById(int studioId) throws SQLException, ClassNotFoundException {
        return studioDAO.getStudioById(studioId);
    }
    
    // You can add more methods as needed
}