package com.valtactics;

import jakarta.persistence.*;
import java.util.UUID;

@Entity
@Table(name = "maps")
public class Maps {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id; 
    @Column(nullable = false)
    private String name;
    @Column(nullable = false)
    private String image_url;
    private boolean is_active = true;

    protected Maps() {
    }

    public Maps(String name, String image_url) {
	   this.name = name;
	   this.image_url = image_url;
    }

    @Override
    public String toString() {
	   return String.format("UUID: %s | name: %s | url: %s | %s\n", id.toString(), name, image_url, is_active ? "true" : "false");
    }
}
