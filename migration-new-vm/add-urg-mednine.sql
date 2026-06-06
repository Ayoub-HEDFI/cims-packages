START TRANSACTION;

-- ============================================================
-- doctors row (auto-increment id)
-- ============================================================
INSERT INTO doctors
  (name, specialty, governorate, departmentId, registrationNumber,
   otherDepartment, otherDepartmentName,
   defaultCathlabs, defaultSamus, defaultNris, defaultUnvs, defaultRadios,
   phone, address, birthday,
   isTest, isEmergencyDoctor, isModeExerciceValid, onMission,
   lastActiveAt, allHospitalCodes)
VALUES
  ('Urg Mednine', 'Emergency Doctor', 'Médenine', 'SAMU 05', 'URG-MED-001',
   1, 'Hopital Mednine',
   '["CHU ARIANA", "CHU CHARLES NICOLLE", "CHU FARHAT HACHED", "CHU FATTOUMA BOURGUIBA", "CHU HABIB BOURGUIBA", "CHU HABIB THAMEUR", "CHU HEDI CHAKER", "CHU IBN JAZZAR", "CHU LA RABTA", "CHU MENZEL BOURGUIBA", "CHU MILITAIRE", "CHU MOHAMED SASSI", "CHU MONGI SLIM LA MARSA", "CHU SAHLOUL", "CHU TAHER MAAMOURI", "CLINIQUE AL MAJED", "CLINIQUE ALALYA", "CLINIQUE AMEN", "CLINIQUE AMEN BIZERTE", "CLINIQUE AMEN MUTUELLE VILLE", "CLINIQUE AMEN NABEUL", "CLINIQUE AMILCAR", "CLINIQUE BASSETINE", "CLINIQUE BEAU SEJOUR", "CLINIQUE CARDIOLOGIQUE DU LAC", "CLINIQUE CARTHAGE MEDICALE", "CLINIQUE CARTHAGENE", "CLINIQUE CORNICHE", "CLINIQUE DJERBA CENTER", "CLINIQUE DJERBA INTERNATIONAL", "CLINIQUE DJERBA LA DOUCE", "CLINIQUE ERRAHMA", "CLINIQUE ESSALEM", "CLINIQUE GENERAL CARDIOVASCULAIRE TUNIS", "CLINIQUE HAMDA LAOUANI", "CLINIQUE HANNIBAL", "CLINIQUE IBN NAFISS", "CLINIQUE MANAR", "CLINIQUE MONTPLAISIR", "CLINIQUE MYRON", "CLINIQUE PASTEUR", "CLINIQUE SAINT AUGUSTIN", "CLINIQUE SOUKRA", "CLINIQUE SYPHAX", "CLINIQUE TAOUFIK", "CLINIQUE ZAYETINE", "HOPITAL REGIONAL KASSERINE", "MEDECIN LIBRE PRATIQUE", "POLYCLINIQUE BERGES DU LAC PBL"]',
   '["SAMU 01", "SAMU 03", "SAMU 04", "SAMU 05", "SAMU 06", "SAMU 08"]',
   '["NRI CHU CHARLES NICOLLE", "NRI CHU LA RABTA", "NRI CHU SAHLOUL", "NRI CHU HABIB BOURGUIBA", "NRI CHU FATTOUMA BOURGUIBA", "NRI CHU HEDI CHAKER"]',
   '["UNV CHU CHARLES NICOLLE", "UNV CHU LA RABTA", "UNV CHU SAHLOUL", "UNV CHU MONGI SLIM LA MARSA", "UNV CHU HABIB BOURGUIBA", "UNV CHU FATTOUMA BOURGUIBA", "UNV CHU HEDI CHAKER", "UNV CHU FARHAT HACHED"]',
   '["RADIO CHU CHARLES NICOLLE", "RADIO CHU LA RABTA", "RADIO CHU SAHLOUL", "RADIO CHU HABIB BOURGUIBA", "RADIO CHU FATTOUMA BOURGUIBA", "RADIO CHU HEDI CHAKER"]',
   '99009900', 'Médenine', '2026-05-06',
   0, 0, 1, 0,
   NOW(), '[]');

SET @new_doctor_id = LAST_INSERT_ID();

-- ============================================================
-- user row (auto-increment id, links to the doctor we just inserted)
-- ============================================================
INSERT INTO `user`
  (email, password, roles, accountStatus, emailVerified, use_2fa, firstLogin, doctorId)
VALUES
  ('urg.mednine@najda-avc.tn',
   '$2b$10$GCRUxCGszwAiqZha8AvGP.KABOvinu1QF4mbAnjBq5YPcnesF2V0i',
   '["doctor"]', 'ACTIVE', 1, 1, 0, @new_doctor_id);

COMMIT;

-- ============================================================
-- Verify
-- ============================================================
SELECT id, name, specialty, governorate, departmentId, registrationNumber,
       otherDepartment, otherDepartmentName, isEmergencyDoctor
  FROM doctors
  WHERE registrationNumber='URG-MED-001';

SELECT id, email, roles, accountStatus, doctorId
  FROM `user`
  WHERE email='urg.mednine@najda-avc.tn';

