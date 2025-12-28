INSERT INTO maps (id, name, image_url, is_active)
VALUES (gen_random_uuid(), 'breeze', 'breeze_url', TRUE)
ON CONFLICT DO NOTHING;
