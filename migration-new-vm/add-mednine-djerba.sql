START TRANSACTION;

-- ============================================================
-- MEDNINE: user only (radios + radio_admins already inserted)
-- Let AUTO_INCREMENT assign the user id (so we don't collide
-- with the existing user.id=760 = zouheir.yahyaoui@rns.tn)
-- ============================================================
INSERT INTO `user`
  (email, password, roles, accountStatus, emailVerified, use_2fa, firstLogin, radioAdminId)
VALUES
  ('radio.mednine@najda.tn',
   '$2b$10$ocxZxCUw4O/eMt2Xb4RIL..DHxOn15BktgohFFFs.IGD9ZsQKSl8S',
   '["admin"]', 'ACTIVE', 1, 1, 0, 8);

-- ============================================================
-- DJERBA: unvs + unv_admins + user (full trio)
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
  (email, password, roles, accountStatus, emailVerified, use_2fa, firstLogin, unvAdminId)
VALUES
  ('unv.djerba@najda.tn',
   '$2b$10$lDEZfkR0dwOXLBJdJrkapeVqZ5BX4tnsKBHymeBJdiECRXWI/MuV2',
   '["admin"]', 'ACTIVE', 1, 1, 0, 23);

COMMIT;

-- Verify
SELECT id, email, roles, accountStatus, radioAdminId, unvAdminId
  FROM `user`
  WHERE email IN ('radio.mednine@najda.tn','unv.djerba@najda.tn');

SELECT id, departmentId, hospitalName FROM unvs WHERE id=10;
SELECT id, name, registrationNumber, unvId FROM unv_admins WHERE id=23;

