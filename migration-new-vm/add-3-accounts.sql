START TRANSACTION;

-- ============================================================
-- 1. Widen radio enums for 'RADIO Hopital Djerba'
-- ============================================================
ALTER TABLE radios
  MODIFY COLUMN departmentId enum(
    'RADIO CHU CHARLES NICOLLE','RADIO CHU LA RABTA','RADIO CHU SAHLOUL',
    'RADIO CHU HABIB BOURGUIBA','RADIO CHU FATTOUMA BOURGUIBA','RADIO CHU HEDI CHAKER',
    'RADIO Hopital Siliana','RADIO Hopital Numerique','RADIO Hopital Mednine',
    'RADIO Hopital Djerba'
  ) NOT NULL;

ALTER TABLE radio_admins
  MODIFY COLUMN departmentId enum(
    'CHU ARIANA','CHU CHARLES NICOLLE','CHU FARHAT HACHED','CHU FATTOUMA BOURGUIBA','CHU HABIB BOURGUIBA','CHU HABIB THAMEUR','CHU HEDI CHAKER','CHU IBN JAZZAR','CHU LA RABTA','CHU MENZEL BOURGUIBA','CHU MILITAIRE','CHU MOHAMED SASSI','CHU MONGI SLIM LA MARSA','CHU SAHLOUL','CHU TAHER MAAMOURI','CLINIQUE AL MAJED','CLINIQUE ALALYA','CLINIQUE AMEN','CLINIQUE AMEN BIZERTE','CLINIQUE AMEN MUTUELLE VILLE','CLINIQUE AMEN NABEUL','CLINIQUE AMILCAR','CLINIQUE BASSETINE','CLINIQUE BEAU SEJOUR','CLINIQUE CARDIOLOGIQUE DU LAC','CLINIQUE CARTHAGE MEDICALE','CLINIQUE CARTHAGENE','CLINIQUE CORNICHE','CLINIQUE DJERBA CENTER','CLINIQUE DJERBA INTERNATIONAL','CLINIQUE DJERBA LA DOUCE','CLINIQUE ERRAHMA','CLINIQUE ESSALEM','CLINIQUE GENERAL CARDIOVASCULAIRE TUNIS','CLINIQUE HAMDA LAOUANI','CLINIQUE HANNIBAL','CLINIQUE IBN NAFISS','CLINIQUE MANAR','CLINIQUE MONTPLAISIR','CLINIQUE MYRON','CLINIQUE PASTEUR','CLINIQUE SAINT AUGUSTIN','CLINIQUE SOUKRA','CLINIQUE SYPHAX','CLINIQUE TAOUFIK','CLINIQUE ZAYETINE','HOPITAL REGIONAL KASSERINE','MEDECIN LIBRE PRATIQUE','POLYCLINIQUE BERGES DU LAC PBL','SAMU 01','SAMU 03','SAMU 04','SAMU 05','SAMU 06','SAMU 08','NRI CHU CHARLES NICOLLE','NRI CHU LA RABTA','NRI CHU SAHLOUL','NRI CHU HABIB BOURGUIBA','NRI CHU FATTOUMA BOURGUIBA','NRI CHU HEDI CHAKER','UNV CHU CHARLES NICOLLE','UNV CHU LA RABTA','UNV CHU SAHLOUL','UNV CHU MONGI SLIM LA MARSA','UNV CHU HABIB BOURGUIBA','UNV CHU FATTOUMA BOURGUIBA','UNV CHU HEDI CHAKER','UNV CHU FARHAT HACHED','RADIO CHU CHARLES NICOLLE','RADIO CHU LA RABTA','RADIO CHU SAHLOUL','RADIO CHU HABIB BOURGUIBA','RADIO CHU FATTOUMA BOURGUIBA','RADIO CHU HEDI CHAKER','RADIO Hopital Siliana','RADIO Hopital Numerique','RADIO Hopital Mednine',
    'RADIO Hopital Djerba'
  ) NOT NULL;

-- ============================================================
-- 2. URG DJERBA: doctor + user
-- ============================================================
INSERT INTO doctors
  (name, specialty, governorate, departmentId, registrationNumber,
   otherDepartment, otherDepartmentName,
   defaultCathlabs, defaultSamus, defaultNris, defaultUnvs, defaultRadios,
   phone, address, birthday,
   isTest, isEmergencyDoctor, isModeExerciceValid, onMission,
   lastActiveAt, allHospitalCodes)
VALUES
  ('Urg Djerba', 'Emergency Doctor', 'Médenine', 'SAMU 05', 'URG-DJER-001',
   1, 'Hopital Djerba',
   '["CHU ARIANA", "CHU CHARLES NICOLLE", "CHU FARHAT HACHED", "CHU FATTOUMA BOURGUIBA", "CHU HABIB BOURGUIBA", "CHU HABIB THAMEUR", "CHU HEDI CHAKER", "CHU IBN JAZZAR", "CHU LA RABTA", "CHU MENZEL BOURGUIBA", "CHU MILITAIRE", "CHU MOHAMED SASSI", "CHU MONGI SLIM LA MARSA", "CHU SAHLOUL", "CHU TAHER MAAMOURI", "CLINIQUE AL MAJED", "CLINIQUE ALALYA", "CLINIQUE AMEN", "CLINIQUE AMEN BIZERTE", "CLINIQUE AMEN MUTUELLE VILLE", "CLINIQUE AMEN NABEUL", "CLINIQUE AMILCAR", "CLINIQUE BASSETINE", "CLINIQUE BEAU SEJOUR", "CLINIQUE CARDIOLOGIQUE DU LAC", "CLINIQUE CARTHAGE MEDICALE", "CLINIQUE CARTHAGENE", "CLINIQUE CORNICHE", "CLINIQUE DJERBA CENTER", "CLINIQUE DJERBA INTERNATIONAL", "CLINIQUE DJERBA LA DOUCE", "CLINIQUE ERRAHMA", "CLINIQUE ESSALEM", "CLINIQUE GENERAL CARDIOVASCULAIRE TUNIS", "CLINIQUE HAMDA LAOUANI", "CLINIQUE HANNIBAL", "CLINIQUE IBN NAFISS", "CLINIQUE MANAR", "CLINIQUE MONTPLAISIR", "CLINIQUE MYRON", "CLINIQUE PASTEUR", "CLINIQUE SAINT AUGUSTIN", "CLINIQUE SOUKRA", "CLINIQUE SYPHAX", "CLINIQUE TAOUFIK", "CLINIQUE ZAYETINE", "HOPITAL REGIONAL KASSERINE", "MEDECIN LIBRE PRATIQUE", "POLYCLINIQUE BERGES DU LAC PBL"]',
   '["SAMU 01", "SAMU 03", "SAMU 04", "SAMU 05", "SAMU 06", "SAMU 08"]',
   '["NRI CHU CHARLES NICOLLE", "NRI CHU LA RABTA", "NRI CHU SAHLOUL", "NRI CHU HABIB BOURGUIBA", "NRI CHU FATTOUMA BOURGUIBA", "NRI CHU HEDI CHAKER"]',
   '["UNV CHU CHARLES NICOLLE", "UNV CHU LA RABTA", "UNV CHU SAHLOUL", "UNV CHU MONGI SLIM LA MARSA", "UNV CHU HABIB BOURGUIBA", "UNV CHU FATTOUMA BOURGUIBA", "UNV CHU HEDI CHAKER", "UNV CHU FARHAT HACHED"]',
   '["RADIO CHU CHARLES NICOLLE", "RADIO CHU LA RABTA", "RADIO CHU SAHLOUL", "RADIO CHU HABIB BOURGUIBA", "RADIO CHU FATTOUMA BOURGUIBA", "RADIO CHU HEDI CHAKER"]',
   '99009900', 'Djerba', '2026-05-06',
   0, 0, 1, 0,
   NOW(), '[]');

SET @urg_djerba_doctor_id = LAST_INSERT_ID();

INSERT INTO `user`
  (email, password, roles, accountStatus, emailVerified, use_2fa, firstLogin, doctorId)
VALUES
  ('urg.djerba@najda-avc.tn',
   '$2b$10$GCRUxCGszwAiqZha8AvGP.KABOvinu1QF4mbAnjBq5YPcnesF2V0i',
   '["doctor"]', 'ACTIVE', 1, 1, 0, @urg_djerba_doctor_id);

-- ============================================================
-- 3. RADIO HCN: radios + radio_admins + user
-- ============================================================
INSERT INTO radios
  (departmentId, hospitalName, chefService, contact, email, lat, lng, availability)
VALUES
  ('RADIO CHU CHARLES NICOLLE', 'RADIO CHU CHARLES NICOLLE, Tunis',
   'Dr Admin RADIO Charles Nicolle', '71 568 000', 'radio.hcn@najda.tn',
   36.8026669, 10.1634124, 'available');

SET @radio_hcn_id = LAST_INSERT_ID();

INSERT INTO radio_admins
  (name, governorate, registrationNumber, departmentId, phone, radioId)
VALUES
  ('Dr Admin RADIO Charles Nicolle', 'Tunis', 'RADIO-HCN-001',
   'RADIO CHU CHARLES NICOLLE', '99 999 999', @radio_hcn_id);

SET @radio_hcn_admin_id = LAST_INSERT_ID();

INSERT INTO `user`
  (email, password, roles, accountStatus, emailVerified, use_2fa, firstLogin, radioAdminId)
VALUES
  ('radio.hcn@najda.tn',
   '$2b$10$ocxZxCUw4O/eMt2Xb4RIL..DHxOn15BktgohFFFs.IGD9ZsQKSl8S',
   '["admin"]', 'ACTIVE', 1, 1, 0, @radio_hcn_admin_id);

-- ============================================================
-- 4. RADIO DJERBA: radios + radio_admins + user
-- ============================================================
INSERT INTO radios
  (departmentId, hospitalName, chefService, contact, email, lat, lng, availability)
VALUES
  ('RADIO Hopital Djerba', 'RADIO Hopital Djerba',
   'Dr Admin RADIO Djerba', '99 999 999', 'radio.djerba@najda.tn',
   33.8081, 10.8451, 'available');

SET @radio_djerba_id = LAST_INSERT_ID();

INSERT INTO radio_admins
  (name, governorate, registrationNumber, departmentId, phone, radioId)
VALUES
  ('Dr Admin RADIO Djerba', 'Médenine', 'RADIO-DJERBA-001',
   'RADIO Hopital Djerba', '99 999 999', @radio_djerba_id);

SET @radio_djerba_admin_id = LAST_INSERT_ID();

INSERT INTO `user`
  (email, password, roles, accountStatus, emailVerified, use_2fa, firstLogin, radioAdminId)
VALUES
  ('radio.djerba@najda.tn',
   '$2b$10$ocxZxCUw4O/eMt2Xb4RIL..DHxOn15BktgohFFFs.IGD9ZsQKSl8S',
   '["admin"]', 'ACTIVE', 1, 1, 0, @radio_djerba_admin_id);

COMMIT;

-- ============================================================
-- Verification
-- ============================================================
SELECT id, name, registrationNumber, departmentId, otherDepartmentName
  FROM doctors WHERE registrationNumber='URG-DJER-001';

SELECT id, departmentId, hospitalName FROM radios
  WHERE departmentId IN ('RADIO CHU CHARLES NICOLLE','RADIO Hopital Djerba')
    AND email IN ('radio.hcn@najda.tn','radio.djerba@najda.tn');

SELECT id, name, registrationNumber, departmentId, radioId FROM radio_admins
  WHERE registrationNumber IN ('RADIO-HCN-001','RADIO-DJERBA-001');

SELECT id, email, roles, accountStatus, doctorId, radioAdminId
  FROM `user`
  WHERE email IN ('urg.djerba@najda-avc.tn','radio.hcn@najda.tn','radio.djerba@najda.tn');

