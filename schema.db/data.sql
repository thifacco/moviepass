-- incluir um usuário
INSERT INTO `moviePass`.`users` (`first_name`, `middle_name`, `last_name`, `email`, `password`, `document`)
VALUES ('James', 'Dillard', 'Dutton', 'james@duttonranch.com', 'paradise', '12345678901');

-- incluir filmes
INSERT INTO `moviePass`.`movies` (`name`)
VALUES ('1883'), ('1923'), ('Yellowstone');

-- incluir sala de cinema
INSERT INTO `moviePass`.`rooms` (`name`)
VALUES ('Sala IMAX');

-- incluir 60 cadeiras na sala (10 linhas x 6 cadeiras por linha)
INSERT INTO `moviePass`.`chairs` (`number`, `row`, `room_id`)
VALUES 
    (1, 'A', 1), (2, 'A', 1), (3, 'A', 1), (4, 'A', 1), (5, 'A', 1), (6, 'A', 1),
    (1, 'B', 1), (2, 'B', 1), (3, 'B', 1), (4, 'B', 1), (5, 'B', 1), (6, 'B', 1),
    (1, 'C', 1), (2, 'C', 1), (3, 'C', 1), (4, 'C', 1), (5, 'C', 1), (6, 'C', 1),
    (1, 'D', 1), (2, 'D', 1), (3, 'D', 1), (4, 'D', 1), (5, 'D', 1), (6, 'D', 1),
    (1, 'E', 1), (2, 'E', 1), (3, 'E', 1), (4, 'E', 1), (5, 'E', 1), (6, 'E', 1),
    (1, 'F', 1), (2, 'F', 1), (3, 'F', 1), (4, 'F', 1), (5, 'F', 1), (6, 'F', 1),
    (1, 'G', 1), (2, 'G', 1), (3, 'G', 1), (4, 'G', 1), (5, 'G', 1), (6, 'G', 1),
    (1, 'H', 1), (2, 'H', 1), (3, 'H', 1), (4, 'H', 1), (5, 'H', 1), (6, 'H', 1),
    (1, 'I', 1), (2, 'I', 1), (3, 'I', 1), (4, 'I', 1), (5, 'I', 1), (6, 'I', 1),
    (1, 'J', 1), (2, 'J', 1), (3, 'J', 1), (4, 'J', 1), (5, 'J', 1), (6, 'J', 1);

-- incluir uma sessão
INSERT INTO `moviePass`.`sessions` (`name`, `movie_id`, `room_id`, `schedule`, `price`)
VALUES ('Sessão Noite - IMAX', 1, 1, '2025-04-15 20:00:00', 45.00);

-- incluir um ticket para o usuário com uma reserva de cadeira
INSERT INTO `moviePass`.`tickets` (`user_id`, `session_id`, `hashcode`, `chair_id`)
VALUES (1, 1, 'TCKT1234', 1);

-- incluir um recibo
INSERT INTO `moviePass`.`receipts` (`ticket_id`, `payment_method`, `total_paid`, `status`)
VALUES (1, 'credit card', 45.00, 'confirmed');

