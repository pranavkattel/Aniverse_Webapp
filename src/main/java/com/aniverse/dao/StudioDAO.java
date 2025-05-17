package com.aniverse.dao;

import com.aniverse.model.Studio;
import com.aniverse.config.Dbconfig;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class StudioDAO {
    
    public List<Studio> getAllStudios() throws SQLException, ClassNotFoundException {
        List<Studio> studios = new ArrayList<>();
        
        String sql = "SELECT studio_id, studio_name FROM studios ORDER BY studio_name";
        
        try (Connection conn = Dbconfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Studio studio = new Studio();
                studio.setStudioId(rs.getInt("studio_id"));
                studio.setStudioName(rs.getString("studio_name"));
                studios.add(studio);
            }
        }
        
        return studios;
    }
    
    public Studio getStudioById(int studioId) throws SQLException, ClassNotFoundException {
        Studio studio = null;
        
        String sql = "SELECT studio_id, studio_name FROM studios WHERE studio_id = ?";
        
        try (Connection conn = Dbconfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, studioId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    studio = new Studio();
                    studio.setStudioId(rs.getInt("studio_id"));
                    studio.setStudioName(rs.getString("studio_name"));
                }
            }
        }
        
        return studio;
    }}
    
    // You can add more methods as needed