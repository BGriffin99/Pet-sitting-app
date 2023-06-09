DROP TABLE IF EXISTS users, pet_owners, pet_sitters, pet_types, pets, sitting_services, bookings, reviews CASCADE;

CREATE TABLE users (
  id SERIAL PRIMARY KEY NOT NULL,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  phone VARCHAR(255),
  city VARCHAR(255),
  country VARCHAR(255),
  password VARCHAR(255) NOT NULL,
  profile_photo VARCHAR(255),
  isPetSitter BOOLEAN DEFAULT false
);

CREATE TABLE pet_owners (
  id SERIAL PRIMARY KEY NOT NULL,
  user_id INTEGER REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE pet_sitters (
  id SERIAL PRIMARY KEY NOT NULL,
  user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
  bio TEXT,
  experience INTEGER,
  nightly_rate INTEGER,
  monday_available BOOLEAN DEFAULT FALSE,
  tuesday_available BOOLEAN DEFAULT FALSE,
  wednesday_available BOOLEAN DEFAULT FALSE,
  thursday_available BOOLEAN DEFAULT FALSE,
  friday_available BOOLEAN DEFAULT FALSE,
  saturday_available BOOLEAN DEFAULT FALSE,
  sunday_available BOOLEAN DEFAULT FALSE
);

CREATE TABLE pet_types (
  id SERIAL PRIMARY KEY NOT NULL,
  type VARCHAR(255) NOT NULL
);

CREATE TABLE pets (
  id SERIAL PRIMARY KEY NOT NULL,
  owner_id INTEGER REFERENCES pet_owners(id) ON DELETE CASCADE,
  user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
  type_id INTEGER REFERENCES pet_types(id) ON DELETE CASCADE,
  name VARCHAR(255) NOT NULL,
  age INTEGER NOT NULL,
  size VARCHAR(255) NOT NULL,
  temperament TEXT,
  medical_conditions TEXT,
  vaccination_status TEXT,
  feeding_instructions TEXT,
  activity_needs TEXT,
  other_notes TEXT,
  profile_photo VARCHAR DEFAULT 'https://static.thenounproject.com/png/1878520-200.png',
  CONSTRAINT fk_type_id FOREIGN KEY (type_id) REFERENCES pet_types(id) ON DELETE CASCADE
);

CREATE TABLE sitting_services (
  id SERIAL PRIMARY KEY NOT NULL,
  type_id INTEGER REFERENCES pet_types(id) ON DELETE CASCADE,
  sitter_id INTEGER REFERENCES pet_sitters(id) ON DELETE CASCADE
);

CREATE TABLE bookings (
  id SERIAL PRIMARY KEY NOT NULL,
  pet_id INTEGER REFERENCES pets(id) ON DELETE CASCADE,
  sitter_id INTEGER REFERENCES pet_sitters(id) ON DELETE CASCADE,
  service_id INTEGER REFERENCES sitting_services(id) ON DELETE CASCADE,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  fee INTEGER NOT NULL,
  is_complete BOOLEAN DEFAULT false,
  status VARCHAR(20) DEFAULT 'pending',
  sitter_accepted BOOLEAN DEFAULT false,
  sitter_rejected BOOLEAN DEFAULT false
);


CREATE TABLE reviews (
  id SERIAL PRIMARY KEY NOT NULL,
  owner_id INTEGER REFERENCES pet_owners(id) ON DELETE CASCADE,
  sitter_id INTEGER REFERENCES pet_sitters(id) ON DELETE CASCADE,
  booking_id INTEGER REFERENCES bookings(id) ON DELETE CASCADE,
  rating INTEGER,
  comment VARCHAR(255)
);
