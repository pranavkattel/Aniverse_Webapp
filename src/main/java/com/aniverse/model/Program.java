package com.aniverse.model;

public class Program {
    private int id;
    private String name;
    private int duration;

    // Constructor
    public Program(int id, String name, int duration) {
        this.id = id;
        this.name = name;
        this.duration = duration;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

  
}