START TRANSACTION;

-- ============================================================
-- 1. Widen radio enums to allow 'RADIO Hopital Mednine'
-- ============================================================
ALTER TABLE radios
  MODIFY COLUMN departmentId enum(
    'RADIO CHU CHARLES NICOLLE','RADIO CHU LA RABTA','RADIO CHU SAHLOUL',
    'RADIO CHU HABIB BOURGUIBA','RADIO CHU FATTOUMA BOURGUIBA','RADIO CHU HEDI CHAKER',
    'RADIO Hopital Siliana','RADIO Hopital Numerique',
    'RADIO Hopital Mednine'
  ) NOT NULL;

ALTER TABLE radio_admins
  MODIFY COLUMN departmentId enum(
    'CHU ARIANA','CHU CHARLES NICOLLE','CHU FARHAT HACHED','CHU FATTOUMA BOURGUIBA','CHU HABIB BOURGUIBA','CHU HABIB THAMEUR','CHU HEDI CHAKER','CHU IBN JAZZAR','CHU LA RABTA','CHU MENZEL BOURGUIBA','CHU MILITAIRE','CHU MOHAMED SASSI','CHU MONGI SLIM LA MARSA','CHU SAHLOUL','CHU TAHER MAAMOURI','CLINIQUE AL MAJED','CLINIQUE ALALYA','CLINIQUE AMEN','CLINIQUE AMEN BIZERTE','CLINIQUE AMEN MUTUELLE VILLE','CLINIQUE AMEN NABEUL','CLINIQUE AMILCAR','CLINIQUE BASSETINE','CLINIQUE BEAU SEJOUR','CLINIQUE CARDIOLOGIQUE DU LAC','CLINIQUE CARTHAGE MEDICALE','CLINIQUE CARTHAGENE','CLINIQUE CORNICHE','CLINIQUE DJERBA CENTER','CLINIQUE DJERBA INTERNATIONAL','CLINIQUE DJERBA LA DOUCE','CLINIQUE ERRAHMA','CLINIQUE ESSALEM','CLINIQUE GENERAL CARDIOVASCULAIRE TUNIS','CLINIQUE HAMDA LAOUANI','CLINIQUE HANNIBAL','CLINIQUE IBN NAFISS','CLINIQUE MANAR','CLINIQUE MONTPLAISIR','CLINIQUE MYRON','CLINIQUE PASTEUR','CLINIQUE SAINT AUGUSTIN','CLINIQUE SOUKRA','CLINIQUE SYPHAX','CLINIQUE TAOUFIK','CLINIQUE ZAYETINE','HOPITAL REGIONAL KASSERINE','MEDECIN LIBRE PRATIQUE','POLYCLINIQUE BERGES DU LAC PBL','SAMU 01','SAMU 03','SAMU 04','SAMU 05','SAMU 06','SAMU 08','NRI CHU CHARLES NICOLLE','NRI CHU LA RABTA','NRI CHU SAHLOUL','NRI CHU HABIB BOURGUIBA','NRI CHU FATTOUMA BOURGUIBA','NRI CHU HEDI CHAKER','UNV CHU CHARLES NICOLLE','UNV CHU LA RABTA','UNV CHU SAHLOUL','UNV CHU MONGI SLIM LA MARSA','UNV CHU HABIB BOURGUIBA','UNV CHU FATTOUMA BOURGUIBA','UNV CHU HEDI CHAKER','UNV CHU FARHAT HACHED','RADIO CHU CHARLES NICOLLE','RADIO CHU LA RABTA','RADIO CHU SAHLOUL','RADIO CHU HABIB BOURGUIBA','RADIO CHU FATTOUMA BOURGUIBA','RADIO CHU HEDI CHAKER','RADIO Hopital Siliana','RADIO Hopital Numerique',
    'RADIO Hopital Mednine'
  ) NOT NULL;

-- ============================================================
-- 2. RADIO MEDNINE: radios + radio_admins + user
-- ============================================================
INSERT INTO radios
  (id, departmentId, hospitalName, chefService, contact, email, lat, lng, availability)
VALUES
  (9, 'RADIO Hopital Mednine', 'RADIO Hopital Mednine', 'Dr Admin RADIO Mednine',
   '99 999 999', 'radio.mednine@najda.tn', 33.3398, 10.4955, 'available');

INSERT INTO radio_admins
  (id, name, governorate, registrationNumber, departmentId, phone, radioId)
VALUES
  (8, 'Dr Admin RADIO Mednine', 'Médenine', 'RADIO-MEDNINE-001',
   'RADIO Hopital Mednine', '99 999 999', 9);

INSERT INTO `user`
  (id, email, password, roles, accountStatus, emailVerified, use_2fa, firstLogin, radioAdminId)
VALUES
  (760, 'radio.mednine@najda.tn',
   '$2b$10$ocxZxCUw4O/eMt2Xb4RIL..DHxOn15BktgohFFFs.IGD9ZsQKSl8S',
   '["admin"]', 'ACTIVE', 1, 1, 0, 8);

-- ============================================================
-- 3. UNV DJERBA: unvs + unv_admins + user
-- ============================================================
INSERT INTO unvs
  (id, departmentId, hospitalName, chefService, contact, email, lat, lng, availability)
VALUES
  (10, 'UNV Hopital Djerba', 'UNV Hopital Djerba', 'Dr Admin UNV Djerba',
   '99 999 999', 'unv.djerba@najda.tn', 33.8081, 10.8451, 'available');

INSERT INTO unv_admins
  (id, name, governorate, registrationNumber, departmentId, phone, unvId)
VALUES
  (23, 'Dr Admin UNV Djerba', 'Médenine', 'UNV-DJERBA-001',
   'UNV Hopital Djerba', '99 999 999', 10);

INSERT INTO `user`
  (id, email, password, roles, accountStatus, emailVerified, use_2fa, firstLogin, unvAdminId)
VALUES
  (761, 'unv.djerba@najda.tn',
   '$2b$10$lDEZfkR0dwOXLBJdJrkapeVqZ5BX4tnsKBHymeBJdiECRXWI/MuV2',
   '["admin"]', 'ACTIVE', 1, 1, 0, 23);

COMMIT;

-- ============================================================
-- Verification
-- ============================================================
SELECT id, departmentId, hospitalName FROM radios WHERE id=9;
SELECT id, name, departmentId, radioId FROM radio_admins WHERE id=8;
SELECT id, departmentId, hospitalName FROM unvs WHERE id=10;
SELECT id, name, departmentId, unvId FROM unv_admins WHERE id=23;
SELECT id, email, roles, accountStatus, radioAdminId, unvAdminId
  FROM `user` WHERE id IN (760, 761);

