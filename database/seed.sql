-- ============================================================
-- RAHANU TECHNOLOGY INITIAL DATA
-- ============================================================

-- ============================================================
-- TEAM MEMBERS
-- ============================================================

INSERT INTO team_members
(full_name, position, role_type, biography, skills, display_order, is_active)
SELECT
    'Eng. Rasuli Omari',
    'Founder',
    'Founder',
    'Eng. Rasuli Omari is the Founder of RAHANU TECHNOLOGY, with a focus on software development, cybersecurity, system design and innovative digital solutions.',
    'Software Development, Cybersecurity, System Design, Web Development, Digital Solutions',
    1,
    TRUE
WHERE NOT EXISTS (
    SELECT 1
    FROM team_members
    WHERE full_name = 'Eng. Rasuli Omari'
);

INSERT INTO team_members
(full_name, position, role_type, biography, skills, display_order, is_active)
SELECT
    'Eng. Nuru Mohamed',
    'Co-Founder',
    'Co-Founder',
    'Eng. Nuru Mohamed is the Co-Founder of RAHANU TECHNOLOGY and contributes to the development of innovative software solutions, technology services and cybersecurity initiatives.',
    'Software Development, Technology Innovation, Cybersecurity, Digital Solutions',
    2,
    TRUE
WHERE NOT EXISTS (
    SELECT 1
    FROM team_members
    WHERE full_name = 'Eng. Nuru Mohamed'
);

INSERT INTO team_members
(full_name, position, role_type, biography, skills, display_order, is_active)
SELECT
    'Eng. Hashim Idd',
    'Full-Stack Developer',
    'Developer',
    'Eng. Hashim Idd is a Full-Stack Developer specializing in the development of modern web applications, backend systems, databases and APIs.',
    'HTML, CSS, JavaScript, Java, Backend Development, Databases, APIs',
    3,
    TRUE
WHERE NOT EXISTS (
    SELECT 1
    FROM team_members
    WHERE full_name = 'Eng. Hashim Idd'
);

INSERT INTO team_members
(full_name, position, role_type, biography, skills, display_order, is_active)
SELECT
    'Eng. Nuhu Nicholous',
    'Full-Stack Developer & Network Engineer',
    'Developer',
    'Eng. Nuhu Nicholous is a Full-Stack Developer and Network Engineer with interests in web applications, backend systems, computer networking and technology infrastructure.',
    'Full-Stack Development, Networking, Backend Development, Databases, Infrastructure',
    4,
    TRUE
WHERE NOT EXISTS (
    SELECT 1
    FROM team_members
    WHERE full_name = 'Eng. Nuhu Nicholous'
);


-- ============================================================
-- SERVICES
-- ============================================================

INSERT INTO services
(title, slug, short_description, description, icon, image,
 display_order, is_featured, is_active)
VALUES
(
    'Website Development',
    'website-development',
    'Professional and responsive websites designed for businesses, organizations and individuals.',
    'We develop modern, responsive and maintainable websites using reliable web technologies. Our solutions are designed to provide good user experience, strong performance and a professional digital presence.',
    'bi-globe2',
    NULL,
    1,
    TRUE,
    TRUE
)
ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    short_description = EXCLUDED.short_description,
    description = EXCLUDED.description,
    icon = EXCLUDED.icon,
    image = EXCLUDED.image,
    display_order = EXCLUDED.display_order,
    is_featured = EXCLUDED.is_featured,
    is_active = EXCLUDED.is_active;


INSERT INTO services
(title, slug, short_description, description, icon, image,
 display_order, is_featured, is_active)
VALUES
(
    'Mobile App Development',
    'mobile-app-development',
    'Modern mobile applications designed to solve real-world business and user needs.',
    'We develop mobile applications that provide practical digital solutions for businesses, organizations and individuals. Applications can be designed for Android, iOS or cross-platform environments.',
    'bi-phone',
    NULL,
    2,
    TRUE,
    TRUE
)
ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    short_description = EXCLUDED.short_description,
    description = EXCLUDED.description,
    icon = EXCLUDED.icon,
    image = EXCLUDED.image,
    display_order = EXCLUDED.display_order,
    is_featured = EXCLUDED.is_featured,
    is_active = EXCLUDED.is_active;


INSERT INTO services
(title, slug, short_description, description, icon, image,
 display_order, is_featured, is_active)
VALUES
(
    'Penetration Testing',
    'penetration-testing',
    'Security testing designed to identify and understand vulnerabilities in authorized systems.',
    'We perform authorized security assessments to identify vulnerabilities in applications, networks and systems. The results help organizations understand security weaknesses and improve their defensive controls.',
    'bi-shield-lock',
    NULL,
    3,
    TRUE,
    TRUE
)
ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    short_description = EXCLUDED.short_description,
    description = EXCLUDED.description,
    icon = EXCLUDED.icon,
    image = EXCLUDED.image,
    display_order = EXCLUDED.display_order,
    is_featured = EXCLUDED.is_featured,
    is_active = EXCLUDED.is_active;


INSERT INTO services
(title, slug, short_description, description, icon, image,
 display_order, is_featured, is_active)
VALUES
(
    'Cybersecurity Services',
    'cybersecurity-services',
    'Security solutions that help organizations protect systems, applications and digital information.',
    'We provide cybersecurity services focused on helping organizations improve their security posture, reduce risks and protect important digital resources.',
    'bi-shield-check',
    NULL,
    4,
    TRUE,
    TRUE
)
ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    short_description = EXCLUDED.short_description,
    description = EXCLUDED.description,
    icon = EXCLUDED.icon,
    image = EXCLUDED.image,
    display_order = EXCLUDED.display_order,
    is_featured = EXCLUDED.is_featured,
    is_active = EXCLUDED.is_active;


INSERT INTO services
(title, slug, short_description, description, icon, image,
 display_order, is_featured, is_active)
VALUES
(
    'Digital Forensics',
    'digital-forensics',
    'Digital investigation and forensic analysis of electronic evidence.',
    'We provide digital forensic services involving the identification, preservation, examination and analysis of digital evidence while maintaining proper forensic procedures.',
    'bi-search',
    NULL,
    5,
    TRUE,
    TRUE
)
ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    short_description = EXCLUDED.short_description,
    description = EXCLUDED.description,
    icon = EXCLUDED.icon,
    image = EXCLUDED.image,
    display_order = EXCLUDED.display_order,
    is_featured = EXCLUDED.is_featured,
    is_active = EXCLUDED.is_active;


INSERT INTO services
(title, slug, short_description, description, icon, image,
 display_order, is_featured, is_active)
VALUES
(
    'Network & Technology Solutions',
    'network-technology-solutions',
    'Network and technology solutions designed to support reliable digital infrastructure.',
    'We provide network and technology solutions including network configuration, troubleshooting, infrastructure support and other technology services designed around organizational requirements.',
    'bi-diagram-3',
    NULL,
    6,
    TRUE,
    TRUE
)
ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    short_description = EXCLUDED.short_description,
    description = EXCLUDED.description,
    icon = EXCLUDED.icon,
    image = EXCLUDED.image,
    display_order = EXCLUDED.display_order,
    is_featured = EXCLUDED.is_featured,
    is_active = EXCLUDED.is_active;


-- ============================================================
-- PROJECTS
-- ============================================================

INSERT INTO projects
(title, slug, short_description, description, technologies,
 image, github_url, live_url, project_date, status, is_featured)
VALUES
(
    'RAHANU Technology Website',
    'rahanu-technology-website',
    'A professional technology company website for presenting software development and cybersecurity services.',
    'A dynamic company website designed to present RAHANU TECHNOLOGY services, projects, team members and technology solutions. The system uses Java Servlet, JSP, PostgreSQL and Bootstrap.',
    'Java, Servlet, JSP, PostgreSQL, Bootstrap, Maven, Tomcat',
    NULL,
    NULL,
    NULL,
    '2026-09-27',
    'In Development',
    TRUE
)
ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    short_description = EXCLUDED.short_description,
    description = EXCLUDED.description,
    technologies = EXCLUDED.technologies,
    image = EXCLUDED.image,
    github_url = EXCLUDED.github_url,
    live_url = EXCLUDED.live_url,
    project_date = EXCLUDED.project_date,
    status = EXCLUDED.status,
    is_featured = EXCLUDED.is_featured;


INSERT INTO projects
(title, slug, short_description, description, technologies,
 image, github_url, live_url, project_date, status, is_featured)
VALUES
(
    'UDOM Online Quiz System',
    'udom-online-quiz-system',
    'An online examination and quiz management system for students, teachers and administrators.',
    'A web-based quiz management platform designed to allow students to take quizzes while teachers manage questions, quizzes and student results.',
    'Java, Servlet, JSP, PostgreSQL, Bootstrap, Maven, Tomcat',
    NULL,
    NULL,
    NULL,
    '2026-09-27',
    'In Development',
    TRUE
)
ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    short_description = EXCLUDED.short_description,
    description = EXCLUDED.description,
    technologies = EXCLUDED.technologies,
    image = EXCLUDED.image,
    github_url = EXCLUDED.github_url,
    live_url = EXCLUDED.live_url,
    project_date = EXCLUDED.project_date,
    status = EXCLUDED.status,
    is_featured = EXCLUDED.is_featured;


INSERT INTO projects
(title, slug, short_description, description, technologies,
 image, github_url, live_url, project_date, status, is_featured)
VALUES
(
    'aGIZA Parcel Delivery System',
    'agiza-parcel-delivery',
    'A digital parcel delivery platform connecting customers with delivery drivers.',
    'A parcel delivery management platform designed to support customers, drivers and administrators while providing location-based delivery services.',
    'React Native, Expo, Node.js, Express, MongoDB, Google Maps',
    NULL,
    NULL,
    NULL,
    '2026-09-27',
    'Completed',
    TRUE
)
ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    short_description = EXCLUDED.short_description,
    description = EXCLUDED.description,
    technologies = EXCLUDED.technologies,
    image = EXCLUDED.image,
    github_url = EXCLUDED.github_url,
    live_url = EXCLUDED.live_url,
    project_date = EXCLUDED.project_date,
    status = EXCLUDED.status,
    is_featured = EXCLUDED.is_featured;


-- ============================================================
-- END OF INITIAL DATA
-- ============================================================