USE recruiter_bot;


--Skills


INSERT INTO skills (name) VALUES
('deduction'),
('pattern-recognition'),
('forensics'),
('research'),
('time-management'),
('public-speaking'),
('systems-design'),
('rapid-prototyping'),
('leadership'),
('project-management'),
('stakeholder-management'),
('woodworking'),
('minimalism'),
('negotiation'),
('chemistry'),
('persuasion'),
('resourcefulness'),
('theoretical-analysis'),
('precision'),
('strategy'),
('crisis-management'),
('sales'),
('team-building'),
('optimism'),
('mentorship'),
('security'),
('loyalty');


-- Candidates


INSERT INTO candidates
(name, experience, availability, traits, quirk)
VALUES
('Sherlock H.', 8, 'Immediate',
 'analytical, blunt',
 'Solves problems by eliminating the impossible; occasionally insufferable in standups.'),

('Hermione G.', 4, '2 weeks',
 'detail-oriented, overachiever',
 'Reads the entire documentation before writing a single line of code.'),

('Tony S.', 12, 'Not looking',
 'confident, innovative',
 'Ships an MVP overnight, refuses to write tests.'),

('Leslie K.', 6, 'Immediate',
 'tenacious, organized',
 'Has a binder for everything, including the binder.'),

('Ron S.', 15, 'Not looking',
 'stubborn, principled',
 'Refuses to use more than one monitor.'),

('Rick S.', 20, 'Immediate',
 'genius, reckless',
 'Solution works, mechanism deeply concerning.'),

('Elle W.', 3, 'Immediate',
 'optimistic, sharp',
 'Underestimated in every standup, correct in every retro.'),

('MacGyver', 10, '2 weeks',
 'calm, improviser',
 'Fixes production outages with duct tape and a paperclip metaphor.'),

('Sheldon C.', 9, 'Immediate',
 'rigid, brilliant',
 'Correct 95% of the time, insufferable 100% of the time.'),

('Katniss E.', 5, 'Immediate',
 'resilient, decisive',
 'Excellent under pressure, terrible with public speaking.'),

('Michael S.', 11, 'Not looking',
 'enthusiastic, chaotic',
 'World''s best boss, according to a mug he bought himself.'),

('Olivia P.', 13, '2 weeks',
 'decisive, intense',
 'Handles it. Whatever it is.'),

('Ted L.', 7, 'Immediate',
 'empathetic, persistent',
 'Turns every technical setback into a folksy metaphor.'),

('Miranda P.', 18, 'Not looking',
 'demanding, decisive',
 'Reviews every PR personally. Says nothing. Everyone panics.'),

('Dwight S.', 9, 'Immediate',
 'intense, loyal',
 'Assistant to the regional backend engineer.');



-- Candidate Skills


INSERT INTO candidate_skills (candidate_id, skill_id) VALUES
(1, 1),
(1, 2),
(1, 3),

(2, 4),
(2, 5),
(2, 6),

(3, 7),
(3, 8),
(3, 9),

(4, 10),
(4, 11),
(4, 6),

(5, 12),
(5, 13),
(5, 14),

(6, 7),
(6, 8),
(6, 15),

(7, 16),
(7, 4),
(7, 6),

(8, 8),
(8, 17),
(8, 15),
(8, 7),

(9, 18),
(9, 2),
(9, 4),

(10, 19),
(10, 20),
(10, 21),

(11, 22),
(11, 6),
(11, 23),

(12, 21),
(12, 14),
(12, 20),
(12, 9),

(13, 23),
(13, 24),
(13, 25),
(13, 6),

(14, 9),
(14, 14),
(14, 11),
(14, 19),

(15, 22),
(15, 14),
(15, 26),
(15, 27);

-- Jobs

INSERT INTO jobs
(title, min_experience, culture_keywords, tagline)
VALUES
('Backend Detective', 3,
 'analytical, autonomous',
 'We have a bug. We have no leads. We have you.'),

('Rapid Prototyping Engineer', 2,
 'innovative, fast-paced',
 'Ship first, document never (kidding — please document).'),

('Developer Relations Lead', 2,
 'energetic, curious',
 'Explain complex things to confused humans, cheerfully.'),

('Engineering Manager, Chaos Team', 5,
 'empathetic, organized',
 'Herd cats. The cats are senior engineers.'),

('Incident Commander', 4,
 'decisive, calm-under-pressure',
 '3am page. You''re the one who picks up.'),

('Sales Engineer', 3,
 'enthusiastic, persistent',
 'Sell the vision, then go build it.');



--job skills
INSERT INTO job_skills (job_id, skill_id) VALUES
(1, 1),
(1, 2),
(1, 3),

(2, 8),
(2, 7),

(3, 6),
(3, 4),

(4, 23),
(4, 11),
(4, 9),

(5, 21),
(5, 20),
(5, 14),

(6, 22),
(6, 6),
(6, 14);