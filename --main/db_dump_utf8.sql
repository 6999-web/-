-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: teaching_office_evaluation
-- ------------------------------------------------------
-- Server version	8.0.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ai_scores`
--

DROP TABLE IF EXISTS `ai_scores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ai_scores` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `evaluation_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_score` decimal(5,2) NOT NULL,
  `indicator_scores` json NOT NULL,
  `parsed_reform_projects` int NOT NULL,
  `parsed_honorary_awards` int NOT NULL,
  `scored_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_ai_scores_evaluation_id` (`evaluation_id`),
  CONSTRAINT `ai_scores_ibfk_1` FOREIGN KEY (`evaluation_id`) REFERENCES `self_evaluations` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ai_scores`
--

LOCK TABLES `ai_scores` WRITE;
/*!40000 ALTER TABLE `ai_scores` DISABLE KEYS */;
/*!40000 ALTER TABLE `ai_scores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alembic_version`
--

DROP TABLE IF EXISTS `alembic_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alembic_version` (
  `version_num` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alembic_version`
--

LOCK TABLES `alembic_version` WRITE;
/*!40000 ALTER TABLE `alembic_version` DISABLE KEYS */;
INSERT INTO `alembic_version` VALUES ('001');
/*!40000 ALTER TABLE `alembic_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `anomalies`
--

DROP TABLE IF EXISTS `anomalies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `anomalies` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `evaluation_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `indicator` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `declared_count` int DEFAULT NULL,
  `parsed_count` int DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `handled_by` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `handled_action` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `handled_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `handled_by` (`handled_by`),
  KEY `ix_anomalies_evaluation_id` (`evaluation_id`),
  CONSTRAINT `anomalies_ibfk_1` FOREIGN KEY (`evaluation_id`) REFERENCES `self_evaluations` (`id`),
  CONSTRAINT `anomalies_ibfk_2` FOREIGN KEY (`handled_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `anomalies`
--

LOCK TABLES `anomalies` WRITE;
/*!40000 ALTER TABLE `anomalies` DISABLE KEYS */;
/*!40000 ALTER TABLE `anomalies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `approvals`
--

DROP TABLE IF EXISTS `approvals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `approvals` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `evaluation_ids` json NOT NULL,
  `decision` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reject_reason` text COLLATE utf8mb4_unicode_ci,
  `approved_by` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `approved_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `approved_by` (`approved_by`),
  CONSTRAINT `approvals_ibfk_1` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `approvals`
--

LOCK TABLES `approvals` WRITE;
/*!40000 ALTER TABLE `approvals` DISABLE KEYS */;
/*!40000 ALTER TABLE `approvals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attachments`
--

DROP TABLE IF EXISTS `attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attachments` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `evaluation_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `indicator` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_size` bigint NOT NULL,
  `file_type` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `storage_path` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `classified_by` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `uploaded_at` datetime NOT NULL,
  `is_archived` tinyint(1) NOT NULL,
  `archived_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `storage_path` (`storage_path`),
  KEY `ix_attachments_evaluation_id` (`evaluation_id`),
  KEY `ix_attachments_indicator` (`indicator`),
  CONSTRAINT `attachments_ibfk_1` FOREIGN KEY (`evaluation_id`) REFERENCES `self_evaluations` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attachments`
--

LOCK TABLES `attachments` WRITE;
/*!40000 ALTER TABLE `attachments` DISABLE KEYS */;
INSERT INTO `attachments` VALUES ('11708888-6ee8-480b-9370-baa3251a22b1','552ef201-bc37-44e7-8e06-00fc55e0970e','teaching_reform_projects','img_v3_02va_511f7666-c413-4828-a801-48efde2c7e3g.jpg',79015,'image/jpeg','552ef201-bc37-44e7-8e06-00fc55e0970e/teaching_reform_projects/ce5db913-8bf4-4415-ae43-e2ad04a93529.jpg','user','2026-02-28 03:31:16',1,'2026-02-28 03:31:16'),('14cf1871-0431-4ce4-a71a-2ab0a456453e','12c0a2df-c048-4061-a23f-22509ce73e93','honorary_awards','鏁欑爺瀹ゅ伐浣滆€冩牳璇勫垎琛?(2).docx',17352,'application/vnd.openxmlformats-officedocument.wordprocessingml.document','12c0a2df-c048-4061-a23f-22509ce73e93/honorary_awards/01edd2f7-a713-4ffe-9948-b5102f13e6ae.docx','user','2026-02-23 13:44:25',1,'2026-02-23 13:44:25'),('206623b7-b707-4d14-a38c-7fa2990247f1','47eb907f-37dc-42de-b099-2059cee5926f','鏁欏杩囩▼绠＄悊','test.txt',17,'text/plain','47eb907f-37dc-42de-b099-2059cee5926f/鏁欏杩囩▼绠＄悊/7daa1e86-f3e8-44ad-870e-1db7596ddd24.txt','user','2026-02-15 08:46:07',1,'2026-02-15 08:46:07'),('3058d1ac-e4f4-4b98-b61f-8625e2f29152','16b20790-2603-4a6b-9e84-09f234401d96','teachingQualityManagement','test_teaching_quality.txt',90,'text/plain','16b20790-2603-4a6b-9e84-09f234401d96/teachingQualityManagement/2ac629e2-3e83-44fb-accb-8a0b21729df3.txt','user','2026-02-28 09:33:30',1,'2026-02-28 09:33:30'),('30dcdc14-4fa2-4b5e-b6bc-aed72e01da2c','16b20790-2603-4a6b-9e84-09f234401d96','courseAssessment','test_course_assessment.txt',81,'text/plain','16b20790-2603-4a6b-9e84-09f234401d96/courseAssessment/c26f2d6c-558a-40ae-b223-dd8053935607.txt','user','2026-02-28 09:33:32',1,'2026-02-28 09:33:32'),('3be0cb82-fd71-4ca2-84c3-ddf7fec15e1e','dd211726-ef92-4fd1-a469-3d279fd02f1e','鏁欏杩囩▼绠＄悊','test.txt',17,'text/plain','dd211726-ef92-4fd1-a469-3d279fd02f1e/鏁欏杩囩▼绠＄悊/275a9751-90b9-442e-9071-cec596fb5659.txt','user','2026-02-15 08:45:24',1,'2026-02-15 08:45:24'),('7a7268b3-9f64-4ec3-925f-916d47a13121','5bfb3b63-17b3-4696-8aad-38ce3dc2134f','teaching_quality','鏁欑爺瀹ゅ伐浣滆€冩牳璇勫垎琛?(2).docx',17352,'application/vnd.openxmlformats-officedocument.wordprocessingml.document','5bfb3b63-17b3-4696-8aad-38ce3dc2134f/teaching_quality/512ebc84-ba06-49c0-bbb7-03e24cfb52d7.docx','user','2026-02-18 03:05:49',1,'2026-02-18 03:05:49'),('879c92d7-1118-4e24-bc87-f161268cf6e4','6a129f43-7aff-4ab3-8f7d-98f2b303f516','honorary_awards','鏁欑爺瀹ゅ伐浣滆€冩牳璇勫垎琛?(2).docx',17352,'application/vnd.openxmlformats-officedocument.wordprocessingml.document','6a129f43-7aff-4ab3-8f7d-98f2b303f516/honorary_awards/a0b33d07-75a2-49cc-9155-c3df16f03daa.docx','user','2026-02-18 03:19:41',1,'2026-02-18 03:19:41'),('96ca12e7-7da8-4ed3-8626-4953bc3140d9','16b20790-2603-4a6b-9e84-09f234401d96','teachingProcessManagement','test_teaching_process.txt',90,'text/plain','16b20790-2603-4a6b-9e84-09f234401d96/teachingProcessManagement/477bbedb-8834-40a0-a6e7-fa3769f493d3.txt','user','2026-02-28 09:33:28',1,'2026-02-28 09:33:28'),('98fa48f2-52c3-4f9c-93d7-6b77d3aa911b','f73821c7-a6e5-47d5-8120-cf5b45b1d4dd','鏁欏杩囩▼绠＄悊','test.txt',17,'text/plain','f73821c7-a6e5-47d5-8120-cf5b45b1d4dd/鏁欏杩囩▼绠＄悊/c9c7f0e2-82fc-40c8-97c7-6546895d16fc.txt','user','2026-02-15 08:44:33',1,'2026-02-15 08:44:33'),('a25da78d-c1e4-4350-924d-38ec2c4884af','a224bec2-e05a-449c-bc74-dc47353e7d74','honorary_awards','鏁欑爺瀹ゅ伐浣滆€冩牳璇勫垎琛?(2).docx',17352,'application/vnd.openxmlformats-officedocument.wordprocessingml.document','a224bec2-e05a-449c-bc74-dc47353e7d74/honorary_awards/33f4b79d-51a0-4c8f-ac27-71d8946621de.docx','user','2026-02-21 06:44:20',1,'2026-02-21 06:44:20'),('fcab8cb3-b99c-4aa8-8b11-48421d1eda85','09f2c7b0-1a2e-43b5-8c61-8ab2a2dac318','student_guidance','鏁欑爺瀹ゅ伐浣滆€冩牳璇勫垎琛?(2).docx',17352,'application/vnd.openxmlformats-officedocument.wordprocessingml.document','09f2c7b0-1a2e-43b5-8c61-8ab2a2dac318/student_guidance/10c8e821-6af1-472d-a610-838cc3964215.docx','user','2026-02-18 03:13:08',1,'2026-02-18 03:13:08');
/*!40000 ALTER TABLE `attachments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `colleges`
--

DROP TABLE IF EXISTS `colleges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `colleges` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dean_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `dean_id` (`dean_id`),
  CONSTRAINT `colleges_ibfk_1` FOREIGN KEY (`dean_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `colleges`
--

LOCK TABLES `colleges` WRITE;
/*!40000 ALTER TABLE `colleges` DISABLE KEYS */;
/*!40000 ALTER TABLE `colleges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `final_scores`
--

DROP TABLE IF EXISTS `final_scores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `final_scores` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `evaluation_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `final_score` decimal(5,2) NOT NULL,
  `summary` text COLLATE utf8mb4_unicode_ci,
  `determined_by` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `determined_at` datetime NOT NULL,
  `version` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `evaluation_id` (`evaluation_id`),
  KEY `determined_by` (`determined_by`),
  CONSTRAINT `final_scores_ibfk_1` FOREIGN KEY (`evaluation_id`) REFERENCES `self_evaluations` (`id`),
  CONSTRAINT `final_scores_ibfk_2` FOREIGN KEY (`determined_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `final_scores`
--

LOCK TABLES `final_scores` WRITE;
/*!40000 ALTER TABLE `final_scores` DISABLE KEYS */;
/*!40000 ALTER TABLE `final_scores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `improvement_plans`
--

DROP TABLE IF EXISTS `improvement_plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `improvement_plans` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `evaluation_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `indicator_item_id` int NOT NULL,
  `target` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `measures` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `charger_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deadline` datetime NOT NULL,
  `status` enum('PENDING','APPROVED','REJECTED','COMPLETED') COLLATE utf8mb4_unicode_ci NOT NULL,
  `supervisor_comment` text COLLATE utf8mb4_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `evaluation_id` (`evaluation_id`),
  KEY `charger_id` (`charger_id`),
  CONSTRAINT `improvement_plans_ibfk_1` FOREIGN KEY (`evaluation_id`) REFERENCES `self_evaluations` (`id`),
  CONSTRAINT `improvement_plans_ibfk_2` FOREIGN KEY (`charger_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `improvement_plans`
--

LOCK TABLES `improvement_plans` WRITE;
/*!40000 ALTER TABLE `improvement_plans` DISABLE KEYS */;
/*!40000 ALTER TABLE `improvement_plans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `insight_summaries`
--

DROP TABLE IF EXISTS `insight_summaries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `insight_summaries` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `evaluation_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `summary` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `generated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `evaluation_id` (`evaluation_id`),
  CONSTRAINT `insight_summaries_ibfk_1` FOREIGN KEY (`evaluation_id`) REFERENCES `self_evaluations` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `insight_summaries`
--

LOCK TABLES `insight_summaries` WRITE;
/*!40000 ALTER TABLE `insight_summaries` DISABLE KEYS */;
/*!40000 ALTER TABLE `insight_summaries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manual_scores`
--

DROP TABLE IF EXISTS `manual_scores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `manual_scores` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `evaluation_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reviewer_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reviewer_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reviewer_role` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `weight` decimal(3,2) NOT NULL,
  `scores` json NOT NULL,
  `submitted_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `reviewer_id` (`reviewer_id`),
  KEY `ix_manual_scores_evaluation_id` (`evaluation_id`),
  CONSTRAINT `manual_scores_ibfk_1` FOREIGN KEY (`evaluation_id`) REFERENCES `self_evaluations` (`id`),
  CONSTRAINT `manual_scores_ibfk_2` FOREIGN KEY (`reviewer_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manual_scores`
--

LOCK TABLES `manual_scores` WRITE;
/*!40000 ALTER TABLE `manual_scores` DISABLE KEYS */;
INSERT INTO `manual_scores` VALUES ('0fb5350b-4d8a-4a07-a1c6-cfe8fde60253','6a129f43-7aff-4ab3-8f7d-98f2b303f516','20000000-0000-0000-0000-000000000001','Evaluator Zhang','evaluation_team',0.70,'[{\"score\": 2.5, \"comment\": \"1111111111111111111111111111\", \"indicator\": \"鏁欏杩囩▼绠＄悊\"}, {\"score\": 2.0, \"comment\": \"111111111111111111111111111111111111111\", \"indicator\": \"璇剧▼寤鸿\"}, {\"score\": 1.5, \"comment\": \"1111111111111111111111111111111111111\", \"indicator\": \"鏁欏鏀归潻椤圭洰\"}, {\"score\": 1.0, \"comment\": \"111111111111111111111111111111111\", \"indicator\": \"鑽ｈ獕琛ㄥ桨\"}, {\"score\": 1.5, \"comment\": \"111111111111111111111111111\", \"indicator\": \"鏁欏璐ㄩ噺\"}, {\"score\": 1.5, \"comment\": \"1111111111111111111111111111111111111111\", \"indicator\": \"瀛︾敓鎸囧\"}, {\"score\": 1.5, \"comment\": \"11111111111111111111111111111111111\", \"indicator\": \"绉戠爺宸ヤ綔\"}, {\"score\": 1.0, \"comment\": \"11111111111111111111111111111111\", \"indicator\": \"鍥㈤槦寤鸿\"}]','2026-02-18 03:20:38'),('16dfbd8d-8fb9-42cb-9d4a-d804cdf01ed5','a224bec2-e05a-449c-bc74-dc47353e7d74','20000000-0000-0000-0000-000000000001','Evaluator Zhang','evaluation_team',0.70,'[{\"score\": 2.0, \"comment\": \"1111111111111111111111111111111\", \"indicator\": \"鏁欏杩囩▼绠＄悊\"}, {\"score\": 1.0, \"comment\": \"1111111111111111111111111\", \"indicator\": \"璇剧▼寤鸿\"}, {\"score\": 1.0, \"comment\": \"111111111111111111111111111111111111111111\", \"indicator\": \"鏁欏鏀归潻椤圭洰\"}, {\"score\": 1.0, \"comment\": \"111111111111111111111111\", \"indicator\": \"鑽ｈ獕琛ㄥ桨\"}, {\"score\": 1.0, \"comment\": \"111111111111111111111111111111111111111\", \"indicator\": \"鏁欏璐ㄩ噺\"}, {\"score\": 1.5, \"comment\": \"1111111111111111111111111111111111111111111111\", \"indicator\": \"瀛︾敓鎸囧\"}, {\"score\": 1.0, \"comment\": \"11111111111111111111111111111\", \"indicator\": \"绉戠爺宸ヤ綔\"}, {\"score\": 1.0, \"comment\": \"11111111111111111111111111111111111111111111111111\", \"indicator\": \"鍥㈤槦寤鸿\"}]','2026-02-21 06:45:13'),('1ca60337-031a-4a06-b7ed-d16025d873d8','47eb907f-37dc-42de-b099-2059cee5926f','20000000-0000-0000-0000-000000000001','Evaluator Zhang','evaluation_team',0.70,'[{\"score\": 8.0, \"comment\": \"test scoring\", \"indicator\": \"鏁欏杩囩▼绠＄悊\"}]','2026-02-15 08:46:18'),('30fb24c3-138c-44af-be9e-bc61959a4343','16b20790-2603-4a6b-9e84-09f234401d96','20000000-0000-0000-0000-000000000001','Evaluator Zhang','evaluation_team',0.70,'[{\"score\": 8.5, \"comment\": \"鏁欏杩囩▼绠＄悊宸ヤ綔鎵庡疄锛屾枃妗ｉ綈鍏╘", \"indicator\": \"鏁欏杩囩▼绠＄悊\"}, {\"score\": 9.0, \"comment\": \"鏁欏璐ㄩ噺绠＄悊鍒跺害瀹屽杽锛屾墽琛屽埌浣峔", \"indicator\": \"鏁欏璐ㄩ噺绠＄悊\"}, {\"score\": 8.0, \"comment\": \"璇剧▼鑰冩牳鏂瑰紡澶氭牱锛岃瘎浠峰悎鐞哱", \"indicator\": \"璇剧▼鑰冩牳\"}]','2026-02-28 09:33:45'),('59ad3dfa-6740-46e1-b054-cc567bf4bd7e','552ef201-bc37-44e7-8e06-00fc55e0970e','20000000-0000-0000-0000-000000000001','Evaluator Zhang','evaluation_team',0.70,'[{\"score\": 2.5, \"comment\": \"1111111111111\", \"indicator\": \"鏁欏杩囩▼绠＄悊\"}, {\"score\": 1.5, \"comment\": \"111111111111111111111111111111111111111\", \"indicator\": \"璇剧▼寤鸿\"}, {\"score\": 2.0, \"comment\": \"1111111111111111111111111111\", \"indicator\": \"鏁欏鏀归潻椤圭洰\"}, {\"score\": 1.5, \"comment\": \"111111111111111111111111111111111111111\", \"indicator\": \"鑽ｈ獕琛ㄥ桨\"}, {\"score\": 1.0, \"comment\": \"111111111111111111111111\", \"indicator\": \"鏁欏璐ㄩ噺\"}, {\"score\": 1.0, \"comment\": \"111111111111111111111111111111111111111111\", \"indicator\": \"瀛︾敓鎸囧\"}, {\"score\": 1.0, \"comment\": \"11111111111111111111111111111111111111111\", \"indicator\": \"绉戠爺宸ヤ綔\"}, {\"score\": 1.0, \"comment\": \"1111111111111\", \"indicator\": \"鍥㈤槦寤鸿\"}]','2026-02-28 03:32:12'),('90ac1d72-3a69-414f-983a-a3fc1cc8fe8c','12c0a2df-c048-4061-a23f-22509ce73e93','20000000-0000-0000-0000-000000000001','Evaluator Zhang','evaluation_team',0.70,'[{\"score\": 1.5, \"comment\": \"1111111111111111111111111\", \"indicator\": \"鏁欏杩囩▼绠＄悊\"}, {\"score\": 1.0, \"comment\": \"111111111111111111111111\", \"indicator\": \"璇剧▼寤鸿\"}, {\"score\": 1.0, \"comment\": \"1111111111111111111111111111111111111111111\", \"indicator\": \"鏁欏鏀归潻椤圭洰\"}, {\"score\": 1.0, \"comment\": \"1111111111111111111111111111111111111111111111111111111\", \"indicator\": \"鑽ｈ獕琛ㄥ桨\"}, {\"score\": 1.0, \"comment\": \"1111111111111111111111111\", \"indicator\": \"鏁欏璐ㄩ噺\"}, {\"score\": 1.0, \"comment\": \"1111111111111111111111111111111111\", \"indicator\": \"瀛︾敓鎸囧\"}, {\"score\": 1.0, \"comment\": \"1111111111111111111111111111111111\", \"indicator\": \"绉戠爺宸ヤ綔\"}, {\"score\": 1.0, \"comment\": \"111111111111111111111111111111111\", \"indicator\": \"鍥㈤槦寤鸿\"}]','2026-02-23 13:45:12'),('b12fff69-69eb-4182-9f8a-5075ea3ef8c4','f6678240-e2cb-4f46-ac31-6735fb9047a4','20000000-0000-0000-0000-000000000001','Evaluator Zhang','evaluation_team',0.70,'[{\"score\": 2.5, \"comment\": \"11111111111111111111111111111111\", \"indicator\": \"鏁欏杩囩▼绠＄悊\"}, {\"score\": 1.0, \"comment\": \"111111111111111111111111111\", \"indicator\": \"璇剧▼寤鸿\"}, {\"score\": 1.0, \"comment\": \"1111111111111111111111111111111111111111111111\", \"indicator\": \"鏁欏鏀归潻椤圭洰\"}, {\"score\": 1.0, \"comment\": \"111111111111111111111111\", \"indicator\": \"鑽ｈ獕琛ㄥ桨\"}, {\"score\": 1.0, \"comment\": \"1111111111111111111111111111111111\", \"indicator\": \"鏁欏璐ㄩ噺\"}, {\"score\": 1.0, \"comment\": \"111111111111111111111111111111111111111111111\", \"indicator\": \"瀛︾敓鎸囧\"}, {\"score\": 1.0, \"comment\": \"111111111111111111111111111\", \"indicator\": \"绉戠爺宸ヤ綔\"}, {\"score\": 1.0, \"comment\": \"1111111111111111111111111\", \"indicator\": \"鍥㈤槦寤鸿\"}]','2026-02-18 02:54:31'),('c50d450e-6427-4b84-9af5-71eb4338a4eb','e56d8557-e341-40ff-9987-1ca7d50d21c7','b2c3d4e5-f6a7-4b5c-9d0e-1f2a3b4c5d6e','Evaluation Team User','evaluation_team',0.70,'[{\"score\": 0.5, \"comment\": \"cccccccccccccccccccccccccccccccc\", \"indicator\": \"鏁欏杩囩▼绠＄悊\"}, {\"score\": 0.5, \"comment\": \"ccccccccccccccccc\", \"indicator\": \"璇剧▼寤鸿\"}, {\"score\": 0.5, \"comment\": \"ccccccccccccccccccccccccccccccccccccccccccccccc\", \"indicator\": \"鏁欏鏀归潻椤圭洰\"}, {\"score\": 0.5, \"comment\": \"ccccccccccccccccc\", \"indicator\": \"鑽ｈ獕琛ㄥ桨\"}, {\"score\": 0.0, \"comment\": \"ccccccccccccccccccccccccccccccccccc\", \"indicator\": \"鏁欏璐ㄩ噺\"}, {\"score\": 0.5, \"comment\": \"cccccccccccccccccccccccccccccccc\", \"indicator\": \"瀛︾敓鎸囧\"}, {\"score\": 0.5, \"comment\": \" cccccccccccccccccccccccccccccc\", \"indicator\": \"绉戠爺宸ヤ綔\"}, {\"score\": 0.5, \"comment\": \"v cccccccccccccccc\", \"indicator\": \"鍥㈤槦寤鸿\"}]','2026-02-14 02:05:55'),('e625c64d-533b-4342-8619-22e669840d43','faa49cfd-090d-4d36-82ac-53c302e6e6e8','20000000-0000-0000-0000-000000000001','Evaluator Zhang','evaluation_team',0.70,'[{\"score\": 3.0, \"comment\": \"1111111\", \"indicator\": \"鏁欏杩囩▼绠＄悊\"}, {\"score\": 2.0, \"comment\": \"1111111111111111111111111111111111111111111111\", \"indicator\": \"璇剧▼寤鸿\"}, {\"score\": 1.0, \"comment\": \"11111111111111111111111111111\", \"indicator\": \"鏁欏鏀归潻椤圭洰\"}, {\"score\": 1.0, \"comment\": \"11111111111111111111111111111111111111111111\", \"indicator\": \"鑽ｈ獕琛ㄥ桨\"}, {\"score\": 1.0, \"comment\": \"1111111111111111111111111111\", \"indicator\": \"鏁欏璐ㄩ噺\"}, {\"score\": 1.0, \"comment\": \"111111111111111111111111111111\", \"indicator\": \"瀛︾敓鎸囧\"}, {\"score\": 0.5, \"comment\": \"111111111111111111111\", \"indicator\": \"绉戠爺宸ヤ綔\"}, {\"score\": 0.5, \"comment\": \"1111111111111111111111111111111\", \"indicator\": \"鍥㈤槦寤鸿\"}]','2026-02-14 03:06:20');
/*!40000 ALTER TABLE `manual_scores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operation_logs`
--

DROP TABLE IF EXISTS `operation_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `operation_logs` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `operation_type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `operator_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `operator_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `operator_role` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `target_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `target_type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `details` json DEFAULT NULL,
  `operated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_operation_logs_target` (`target_id`),
  KEY `ix_operation_logs_target_id` (`target_id`),
  KEY `idx_operation_logs_operator` (`operator_id`),
  KEY `ix_operation_logs_operator_id` (`operator_id`),
  CONSTRAINT `operation_logs_ibfk_1` FOREIGN KEY (`operator_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operation_logs`
--

LOCK TABLES `operation_logs` WRITE;
/*!40000 ALTER TABLE `operation_logs` DISABLE KEYS */;
INSERT INTO `operation_logs` VALUES ('00e91b53-d28d-4790-957e-e9ea35b629e7','manual_score','20000000-0000-0000-0000-000000000001','Evaluator Zhang','evaluation_team','b12fff69-69eb-4182-9f8a-5075ea3ef8c4','manual_score','{\"action\": \"submit_manual_score\", \"weight\": 0.7, \"scores_count\": 8, \"evaluation_id\": \"f6678240-e2cb-4f46-ac31-6735fb9047a4\", \"reviewer_role\": \"evaluation_team\"}','2026-02-18 02:54:31'),('083893ce-0511-41ea-a43a-38e8440a029c','submit','10000000-0000-0000-0000-000000000001','Director Zhang','teaching_office','47eb907f-37dc-42de-b099-2059cee5926f','self_evaluation','{\"action\": \"submit_and_lock\", \"evaluation_id\": \"47eb907f-37dc-42de-b099-2059cee5926f\", \"evaluation_year\": 2029, \"attachments_count\": 1, \"teaching_office_id\": \"00000000-0000-0000-0000-000000000001\"}','2026-02-15 08:46:09'),('0ae08d45-74fe-47d2-b1d7-7154d8faf3d3','submit','10000000-0000-0000-0000-000000000001','Director Zhang','teaching_office','d3d4d03f-d05e-46a3-b7fa-16f1d00721bc','self_evaluation','{\"action\": \"submit\", \"evaluation_id\": \"d3d4d03f-d05e-46a3-b7fa-16f1d00721bc\", \"evaluation_year\": 2026, \"attachments_count\": 0, \"teaching_office_id\": \"00000000-0000-0000-0000-000000000001\"}','2026-02-28 09:10:37'),('0b8b662f-bc9e-4f68-858a-b27ab28a91f0','manual_score','20000000-0000-0000-0000-000000000001','Evaluator Zhang','evaluation_team','0fb5350b-4d8a-4a07-a1c6-cfe8fde60253','manual_score','{\"action\": \"submit_manual_score\", \"weight\": 0.7, \"scores_count\": 8, \"evaluation_id\": \"6a129f43-7aff-4ab3-8f7d-98f2b303f516\", \"reviewer_role\": \"evaluation_team\"}','2026-02-18 03:20:38'),('0fbb8315-f0d1-4879-ac8c-eb50e66dee6d','manual_score','20000000-0000-0000-0000-000000000001','Evaluator Zhang','evaluation_team','e625c64d-533b-4342-8619-22e669840d43','manual_score','{\"action\": \"submit_manual_score\", \"weight\": 0.7, \"scores_count\": 8, \"evaluation_id\": \"faa49cfd-090d-4d36-82ac-53c302e6e6e8\", \"reviewer_role\": \"evaluation_team\"}','2026-02-14 03:06:20'),('1728ae58-914a-44a3-90dc-10fc009bd33f','submit','10000000-0000-0000-0000-000000000001','Director Zhang','teaching_office','faa49cfd-090d-4d36-82ac-53c302e6e6e8','self_evaluation','{\"action\": \"submit_and_lock\", \"evaluation_id\": \"faa49cfd-090d-4d36-82ac-53c302e6e6e8\", \"evaluation_year\": 2026, \"attachments_count\": 0, \"teaching_office_id\": \"00000000-0000-0000-0000-000000000001\"}','2026-02-14 02:40:34'),('17aec1b5-cf0c-4cf1-8043-938559393c37','submit','10000000-0000-0000-0000-000000000001','Director Zhang','teaching_office','dd211726-ef92-4fd1-a469-3d279fd02f1e','self_evaluation','{\"action\": \"submit_and_lock\", \"evaluation_id\": \"dd211726-ef92-4fd1-a469-3d279fd02f1e\", \"evaluation_year\": 2033, \"attachments_count\": 1, \"teaching_office_id\": \"00000000-0000-0000-0000-000000000001\"}','2026-02-15 08:45:26'),('268bb667-7e20-4d7c-84b9-ba6ee7e2e15d','manual_score','20000000-0000-0000-0000-000000000001','Evaluator Zhang','evaluation_team','59ad3dfa-6740-46e1-b054-cc567bf4bd7e','manual_score','{\"action\": \"submit_manual_score\", \"weight\": 0.7, \"scores_count\": 8, \"evaluation_id\": \"552ef201-bc37-44e7-8e06-00fc55e0970e\", \"reviewer_role\": \"evaluation_team\"}','2026-02-28 03:32:12'),('27b38b56-80ed-4770-9472-b81f133eead6','manual_score','20000000-0000-0000-0000-000000000001','Evaluator Zhang','evaluation_team','30fb24c3-138c-44af-be9e-bc61959a4343','manual_score','{\"action\": \"submit_manual_score\", \"weight\": 0.7, \"scores_count\": 3, \"evaluation_id\": \"16b20790-2603-4a6b-9e84-09f234401d96\", \"reviewer_role\": \"evaluation_team\"}','2026-02-28 09:33:45'),('349d75b6-37da-4060-8e13-c0cad6633788','ai_score','10000000-0000-0000-0000-000000000001','Director Zhang','teaching_office','faa49cfd-090d-4d36-82ac-53c302e6e6e8','ai_scoring_task','{\"action\": \"trigger_ai_scoring\", \"evaluation_id\": \"faa49cfd-090d-4d36-82ac-53c302e6e6e8\", \"attachments_count\": 0}','2026-02-14 02:40:34'),('34ca4185-20b9-4048-b6a6-91550ff74d3f','submit','10000000-0000-0000-0000-000000000001','Director Zhang','teaching_office','b252b8cc-21d9-4024-a555-89215af459c6','self_evaluation','{\"action\": \"submit\", \"evaluation_id\": \"b252b8cc-21d9-4024-a555-89215af459c6\", \"evaluation_year\": 2026, \"attachments_count\": 0, \"teaching_office_id\": \"00000000-0000-0000-0000-000000000001\"}','2026-02-28 08:42:57'),('3d6a9758-e9c6-4632-818e-038639b97f24','submit','10000000-0000-0000-0000-000000000001','Director Zhang','teaching_office','396a42e5-1f8f-4742-a00b-841d6d3b8606','self_evaluation','{\"action\": \"submit_and_lock\", \"evaluation_id\": \"396a42e5-1f8f-4742-a00b-841d6d3b8606\", \"evaluation_year\": 2027, \"attachments_count\": 0, \"teaching_office_id\": \"00000000-0000-0000-0000-000000000001\"}','2026-02-18 02:37:47'),('4209eedc-db26-4c0d-a45e-21591eb56d19','ai_score','a1b2c3d4-e5f6-4a5b-8c9d-0e1f2a3b4c5d','Teaching Office User','teaching_office','e56d8557-e341-40ff-9987-1ca7d50d21c7','ai_scoring_task','{\"action\": \"trigger_ai_scoring\", \"evaluation_id\": \"e56d8557-e341-40ff-9987-1ca7d50d21c7\", \"attachments_count\": 0}','2026-02-13 14:16:31'),('65fe29db-ae38-4d84-989b-61e16471425e','submit','10000000-0000-0000-0000-000000000001','Director Zhang','teaching_office','12c0a2df-c048-4061-a23f-22509ce73e93','self_evaluation','{\"action\": \"submit\", \"evaluation_id\": \"12c0a2df-c048-4061-a23f-22509ce73e93\", \"evaluation_year\": 2026, \"attachments_count\": 1, \"teaching_office_id\": \"00000000-0000-0000-0000-000000000001\"}','2026-02-23 13:44:25'),('6e08d08e-7aad-422b-a0c9-41865c9c4816','submit','10000000-0000-0000-0000-000000000001','Director Zhang','teaching_office','d46ffe3a-5948-41dc-ac06-1d31c54aadcd','self_evaluation','{\"action\": \"submit\", \"evaluation_id\": \"d46ffe3a-5948-41dc-ac06-1d31c54aadcd\", \"evaluation_year\": 2026, \"attachments_count\": 0, \"teaching_office_id\": \"00000000-0000-0000-0000-000000000001\"}','2026-02-18 03:07:29'),('87c31ebe-e82e-47db-aead-abbb9794f286','submit','10000000-0000-0000-0000-000000000001','Director Zhang','teaching_office','d922392d-38cd-40df-911d-c114f84bc4d2','self_evaluation','{\"action\": \"submit\", \"evaluation_id\": \"d922392d-38cd-40df-911d-c114f84bc4d2\", \"evaluation_year\": 2026, \"attachments_count\": 0, \"teaching_office_id\": \"00000000-0000-0000-0000-000000000001\"}','2026-02-28 08:07:33'),('91148390-6d91-411b-829f-9a5fbdd8a5be','submit','10000000-0000-0000-0000-000000000001','Director Zhang','teaching_office','74d19180-d003-4b24-8c16-34873a9b49e1','self_evaluation','{\"action\": \"submit\", \"evaluation_id\": \"74d19180-d003-4b24-8c16-34873a9b49e1\", \"evaluation_year\": 2026, \"attachments_count\": 0, \"teaching_office_id\": \"00000000-0000-0000-0000-000000000001\"}','2026-02-22 13:02:46'),('9878bea7-3ad6-4be9-a229-f1aef3126189','submit','10000000-0000-0000-0000-000000000001','Director Zhang','teaching_office','6a129f43-7aff-4ab3-8f7d-98f2b303f516','self_evaluation','{\"action\": \"submit\", \"evaluation_id\": \"6a129f43-7aff-4ab3-8f7d-98f2b303f516\", \"evaluation_year\": 2026, \"attachments_count\": 1, \"teaching_office_id\": \"00000000-0000-0000-0000-000000000001\"}','2026-02-18 03:19:41'),('a2116ce4-9f7a-4657-acc4-4ee33aebd6c8','submit','10000000-0000-0000-0000-000000000002','Director Li','teaching_office','ccec9564-17ea-49ee-8fcf-33c875dd881d','self_evaluation','{\"action\": \"submit_and_lock\", \"evaluation_id\": \"ccec9564-17ea-49ee-8fcf-33c875dd881d\", \"evaluation_year\": 2026, \"attachments_count\": 0, \"teaching_office_id\": \"00000000-0000-0000-0000-000000000002\"}','2026-02-18 02:35:37'),('a263f1e6-4618-485f-ac03-a9e898db05f6','submit','10000000-0000-0000-0000-000000000001','Director Zhang','teaching_office','16b20790-2603-4a6b-9e84-09f234401d96','self_evaluation','{\"action\": \"submit\", \"evaluation_id\": \"16b20790-2603-4a6b-9e84-09f234401d96\", \"evaluation_year\": 2026, \"attachments_count\": 3, \"teaching_office_id\": \"00000000-0000-0000-0000-000000000001\"}','2026-02-28 09:33:34'),('b1f6b90e-b87f-415b-881e-aee680679d22','submit','10000000-0000-0000-0000-000000000001','Director Zhang','teaching_office','09f2c7b0-1a2e-43b5-8c61-8ab2a2dac318','self_evaluation','{\"action\": \"submit\", \"evaluation_id\": \"09f2c7b0-1a2e-43b5-8c61-8ab2a2dac318\", \"evaluation_year\": 2026, \"attachments_count\": 1, \"teaching_office_id\": \"00000000-0000-0000-0000-000000000001\"}','2026-02-18 03:13:08'),('bdfa27a0-dc90-4bcd-a161-083fe9ea9f0a','manual_score','b2c3d4e5-f6a7-4b5c-9d0e-1f2a3b4c5d6e','Evaluation Team User','evaluation_team','c50d450e-6427-4b84-9af5-71eb4338a4eb','manual_score','{\"action\": \"submit_manual_score\", \"weight\": 0.7, \"scores_count\": 8, \"evaluation_id\": \"e56d8557-e341-40ff-9987-1ca7d50d21c7\", \"reviewer_role\": \"evaluation_team\"}','2026-02-14 02:05:55'),('c4b0b442-09ed-4b14-876c-6974da7ed143','submit','10000000-0000-0000-0000-000000000001','Director Zhang','teaching_office','a224bec2-e05a-449c-bc74-dc47353e7d74','self_evaluation','{\"action\": \"submit\", \"evaluation_id\": \"a224bec2-e05a-449c-bc74-dc47353e7d74\", \"evaluation_year\": 2026, \"attachments_count\": 1, \"teaching_office_id\": \"00000000-0000-0000-0000-000000000001\"}','2026-02-21 06:44:20'),('d1c8e73f-a0b6-4ab0-b1ad-98567c4f348c','manual_score','20000000-0000-0000-0000-000000000001','Evaluator Zhang','evaluation_team','90ac1d72-3a69-414f-983a-a3fc1cc8fe8c','manual_score','{\"action\": \"submit_manual_score\", \"weight\": 0.7, \"scores_count\": 8, \"evaluation_id\": \"12c0a2df-c048-4061-a23f-22509ce73e93\", \"reviewer_role\": \"evaluation_team\"}','2026-02-23 13:45:12'),('dcc42c90-a597-499f-87be-d5af4be34011','submit','10000000-0000-0000-0000-000000000001','Director Zhang','teaching_office','f73821c7-a6e5-47d5-8120-cf5b45b1d4dd','self_evaluation','{\"action\": \"submit_and_lock\", \"evaluation_id\": \"f73821c7-a6e5-47d5-8120-cf5b45b1d4dd\", \"evaluation_year\": 2024, \"attachments_count\": 1, \"teaching_office_id\": \"00000000-0000-0000-0000-000000000001\"}','2026-02-15 08:44:35'),('df2bf73a-5446-424e-b3c2-1266a8ec78fd','submit','10000000-0000-0000-0000-000000000001','Director Zhang','teaching_office','f6678240-e2cb-4f46-ac31-6735fb9047a4','self_evaluation','{\"action\": \"submit\", \"evaluation_id\": \"f6678240-e2cb-4f46-ac31-6735fb9047a4\", \"evaluation_year\": 2026, \"attachments_count\": 0, \"teaching_office_id\": \"00000000-0000-0000-0000-000000000001\"}','2026-02-18 02:52:29'),('dff13402-3087-4778-bf82-733d4c5daeee','manual_score','20000000-0000-0000-0000-000000000001','Evaluator Zhang','evaluation_team','1ca60337-031a-4a06-b7ed-d16025d873d8','manual_score','{\"action\": \"submit_manual_score\", \"weight\": 0.7, \"scores_count\": 1, \"evaluation_id\": \"47eb907f-37dc-42de-b099-2059cee5926f\", \"reviewer_role\": \"evaluation_team\"}','2026-02-15 08:46:18'),('e4a042cd-7979-4907-bf6b-7dd854b312b3','manual_score','20000000-0000-0000-0000-000000000001','Evaluator Zhang','evaluation_team','16dfbd8d-8fb9-42cb-9d4a-d804cdf01ed5','manual_score','{\"action\": \"submit_manual_score\", \"weight\": 0.7, \"scores_count\": 8, \"evaluation_id\": \"a224bec2-e05a-449c-bc74-dc47353e7d74\", \"reviewer_role\": \"evaluation_team\"}','2026-02-21 06:45:13'),('ee81a612-9b24-4eee-962c-ddae3227587c','submit','10000000-0000-0000-0000-000000000001','Director Zhang','teaching_office','b445cb67-a5aa-4223-95bb-7cf3c57bc63d','self_evaluation','{\"action\": \"submit\", \"evaluation_id\": \"b445cb67-a5aa-4223-95bb-7cf3c57bc63d\", \"evaluation_year\": 2026, \"attachments_count\": 0, \"teaching_office_id\": \"00000000-0000-0000-0000-000000000001\"}','2026-02-28 09:35:53'),('f190d923-82a6-487c-91ea-a5073c2e4f82','submit','10000000-0000-0000-0000-000000000001','Director Zhang','teaching_office','552ef201-bc37-44e7-8e06-00fc55e0970e','self_evaluation','{\"action\": \"submit\", \"evaluation_id\": \"552ef201-bc37-44e7-8e06-00fc55e0970e\", \"evaluation_year\": 2026, \"attachments_count\": 1, \"teaching_office_id\": \"00000000-0000-0000-0000-000000000001\"}','2026-02-28 03:31:16'),('f3855b43-364d-4831-831d-da146ca6390c','submit','a1b2c3d4-e5f6-4a5b-8c9d-0e1f2a3b4c5d','Teaching Office User','teaching_office','e56d8557-e341-40ff-9987-1ca7d50d21c7','self_evaluation','{\"action\": \"submit_and_lock\", \"evaluation_id\": \"e56d8557-e341-40ff-9987-1ca7d50d21c7\", \"evaluation_year\": 2026, \"attachments_count\": 0, \"teaching_office_id\": \"a1b2c3d4-e5f6-4a5b-8c9d-111111111111\"}','2026-02-13 14:16:31'),('f39a04a0-6daa-48ac-a990-396a986063db','submit','10000000-0000-0000-0000-000000000001','Director Zhang','teaching_office','a74ebde3-a983-4a70-a48d-df8a9f1b2053','self_evaluation','{\"action\": \"submit\", \"evaluation_id\": \"a74ebde3-a983-4a70-a48d-df8a9f1b2053\", \"evaluation_year\": 2026, \"attachments_count\": 0, \"teaching_office_id\": \"00000000-0000-0000-0000-000000000001\"}','2026-02-28 08:25:50'),('fbde868f-24ce-4194-a7a8-0915088d62b7','submit','10000000-0000-0000-0000-000000000001','Director Zhang','teaching_office','531ef2d0-1974-4130-94a9-e055af16253f','self_evaluation','{\"action\": \"submit\", \"evaluation_id\": \"531ef2d0-1974-4130-94a9-e055af16253f\", \"evaluation_year\": 2026, \"attachments_count\": 0, \"teaching_office_id\": \"00000000-0000-0000-0000-000000000001\"}','2026-02-28 08:18:20'),('ffdbbdd3-30dc-4519-acdd-2e1e88c77f4a','submit','10000000-0000-0000-0000-000000000003','Director Wang','teaching_office','08a3a8b7-cad4-48ef-ad1f-7a21c8b3c0d6','self_evaluation','{\"action\": \"submit_and_lock\", \"evaluation_id\": \"08a3a8b7-cad4-48ef-ad1f-7a21c8b3c0d6\", \"evaluation_year\": 2026, \"attachments_count\": 0, \"teaching_office_id\": \"00000000-0000-0000-0000-000000000003\"}','2026-02-18 02:35:43');
/*!40000 ALTER TABLE `operation_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publications`
--

DROP TABLE IF EXISTS `publications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publications` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `evaluation_ids` json NOT NULL,
  `published_by` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `published_at` datetime NOT NULL,
  `distributed_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `published_by` (`published_by`),
  CONSTRAINT `publications_ibfk_1` FOREIGN KEY (`published_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publications`
--

LOCK TABLES `publications` WRITE;
/*!40000 ALTER TABLE `publications` DISABLE KEYS */;
/*!40000 ALTER TABLE `publications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `self_evaluations`
--

DROP TABLE IF EXISTS `self_evaluations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `self_evaluations` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `teaching_office_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `evaluation_year` int NOT NULL,
  `content` json NOT NULL,
  `status` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `submitted_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `version` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_self_evaluations_evaluation_year` (`evaluation_year`),
  KEY `ix_self_evaluations_teaching_office_id` (`teaching_office_id`),
  CONSTRAINT `self_evaluations_ibfk_1` FOREIGN KEY (`teaching_office_id`) REFERENCES `teaching_offices` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `self_evaluations`
--

LOCK TABLES `self_evaluations` WRITE;
/*!40000 ALTER TABLE `self_evaluations` DISABLE KEYS */;
INSERT INTO `self_evaluations` VALUES ('08a3a8b7-cad4-48ef-ad1f-7a21c8b3c0d6','00000000-0000-0000-0000-000000000003',2026,'{\"teamBuilding\": \"娴嬭瘯鍐呭\", \"honoraryAwards\": 1, \"studentGuidance\": \"娴嬭瘯鍐呭\", \"teachingQuality\": \"娴嬭瘯鍐呭\", \"courseConstruction\": \"娴嬭瘯鍐呭\", \"scientificResearch\": \"娴嬭瘯鍐呭\", \"teachingReformProjects\": 1, \"teachingProcessManagement\": \"娴嬭瘯鍐呭\"}','draft','2026-02-18 02:35:43','2026-02-18 02:35:41','2026-02-18 02:44:13',1),('09f2c7b0-1a2e-43b5-8c61-8ab2a2dac318','00000000-0000-0000-0000-000000000001',2026,'{\"highlights\": {\"teachingHonors\": {\"items\": [], \"totalScore\": 0}, \"teachingCompetitions\": {\"items\": [], \"totalScore\": 0}, \"innovationCompetitions\": {\"items\": [], \"totalScore\": 0}, \"teachingReformProjects\": {\"items\": [], \"totalScore\": 0}}, \"negativeList\": {\"ideologyIssues\": {\"count\": 0, \"deduction\": 0}, \"ethicsViolations\": {\"count\": 0, \"deduction\": 0}, \"teachingAccidents\": {\"count\": 0, \"deduction\": 0}, \"workloadIncomplete\": {\"deduction\": 0, \"percentage\": 0}}, \"evaluationYear\": 2026, \"regularTeaching\": {\"courseAssessment\": {\"content\": \"qqqqqqqqqqqqqqqqq\", \"maxScore\": 10, \"selfScore\": 2}, \"archiveManagement\": {\"content\": \"qqqqqqqqqqqqqqqqqqqqqqqqqq\", \"maxScore\": 10, \"selfScore\": 10}, \"educationResearch\": {\"content\": \"qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq\", \"maxScore\": 10, \"selfScore\": 1.5}, \"courseConstruction\": {\"content\": \"qqqqqqqqqqqqqqqqqqqqqqqqqq\", \"maxScore\": 10, \"selfScore\": 1.5}, \"researchAndExchange\": {\"content\": \"qqqqqqqqqqqqqqqqqqqqq\", \"maxScore\": 10, \"selfScore\": 2.5}, \"teacherTeamBuilding\": {\"content\": \"qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq\", \"maxScore\": 10, \"selfScore\": 2}, \"teachingProcessManagement\": {\"content\": \"qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq\", \"maxScore\": 10, \"selfScore\": 2}, \"teachingQualityManagement\": {\"content\": \"qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq\", \"maxScore\": 10, \"selfScore\": 1.5}}, \"teachingOfficeId\": \"00000000-0000-0000-0000-000000000001\"}','submitted','2026-02-18 03:13:08','2026-02-18 03:13:08','2026-02-18 03:13:08',1),('12c0a2df-c048-4061-a23f-22509ce73e93','00000000-0000-0000-0000-000000000001',2026,'{\"highlights\": {\"teachingHonors\": {\"items\": [], \"totalScore\": 0}, \"teachingCompetitions\": {\"items\": [], \"totalScore\": 0}, \"innovationCompetitions\": {\"items\": [], \"totalScore\": 0}, \"teachingReformProjects\": {\"items\": [], \"totalScore\": 0}}, \"negativeList\": {\"ideologyIssues\": {\"count\": 0, \"deduction\": 0}, \"ethicsViolations\": {\"count\": 0, \"deduction\": 0}, \"teachingAccidents\": {\"count\": 0, \"deduction\": 0}, \"workloadIncomplete\": {\"deduction\": 0, \"percentage\": 0}}, \"evaluationYear\": 2026, \"regularTeaching\": {\"courseAssessment\": {\"content\": \"111111111111111111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 1.5}, \"archiveManagement\": {\"content\": \"1111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 1.5}, \"educationResearch\": {\"content\": \"111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 1}, \"courseConstruction\": {\"content\": \"111111111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 1}, \"researchAndExchange\": {\"content\": \"111111111111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 1}, \"teacherTeamBuilding\": {\"content\": \"11111111111111111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 1}, \"teachingProcessManagement\": {\"content\": \"11111111111\", \"maxScore\": 10, \"selfScore\": 1}, \"teachingQualityManagement\": {\"content\": \"111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 1.5}}, \"teachingOfficeId\": \"00000000-0000-0000-0000-000000000001\"}','submitted','2026-02-23 13:44:25','2026-02-23 13:44:06','2026-02-23 13:44:25',1),('16b20790-2603-4a6b-9e84-09f234401d96','00000000-0000-0000-0000-000000000001',2026,'{\"courseAssessment\": {\"content\": \"璇剧▼鑰冩牳宸ヤ綔鍐呭\", \"selfScore\": 8.0}, \"teachingProcessManagement\": {\"content\": \"鏁欏杩囩▼绠＄悊宸ヤ綔鍐呭\", \"selfScore\": 8.5}, \"teachingQualityManagement\": {\"content\": \"鏁欏璐ㄩ噺绠＄悊宸ヤ綔鍐呭\", \"selfScore\": 9.0}}','submitted','2026-02-28 17:33:34','2026-02-28 09:32:56','2026-02-28 17:33:34',1),('396a42e5-1f8f-4742-a00b-841d6d3b8606','00000000-0000-0000-0000-000000000001',2027,'{\"teamBuilding\": \"娴嬭瘯鍐呭\", \"honoraryAwards\": 1, \"studentGuidance\": \"娴嬭瘯鍐呭\", \"teachingQuality\": \"娴嬭瘯鍐呭\", \"courseConstruction\": \"娴嬭瘯鍐呭\", \"scientificResearch\": \"娴嬭瘯鍐呭\", \"teachingReformProjects\": 1, \"teachingProcessManagement\": \"娴嬭瘯鍐呭\"}','locked','2026-02-18 02:37:47','2026-02-18 02:37:45','2026-02-18 02:37:47',1),('47eb907f-37dc-42de-b099-2059cee5926f','00000000-0000-0000-0000-000000000001',2029,'{\"regularTeaching\": {\"teachingProcessManagement\": {\"content\": \"test content\", \"selfScore\": 8}}}','locked','2026-02-15 08:46:09','2026-02-15 08:46:05','2026-02-15 08:46:09',1),('531ef2d0-1974-4130-94a9-e055af16253f','00000000-0000-0000-0000-000000000001',2026,'{\"highlights\": {\"teachingHonors\": {\"items\": [], \"totalScore\": 0}, \"teachingCompetitions\": {\"items\": [], \"totalScore\": 0}, \"innovationCompetitions\": {\"items\": [], \"totalScore\": 0}, \"teachingReformProjects\": {\"items\": [], \"totalScore\": 0}}, \"negativeList\": {\"ideologyIssues\": {\"count\": 0, \"deduction\": 0}, \"ethicsViolations\": {\"count\": 0, \"deduction\": 0}, \"teachingAccidents\": {\"count\": 0, \"deduction\": 0}, \"workloadIncomplete\": {\"deduction\": 0, \"percentage\": 0}}, \"evaluationYear\": 2026, \"regularTeaching\": {\"courseAssessment\": {\"content\": \"111111111111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 0.5}, \"archiveManagement\": {\"content\": \"1111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 0.5}, \"educationResearch\": {\"content\": \"111111111111111111\", \"maxScore\": 10, \"selfScore\": 0.5}, \"courseConstruction\": {\"content\": \"1111111111111111\", \"maxScore\": 10, \"selfScore\": 0.5}, \"researchAndExchange\": {\"content\": \"111111111111111111\", \"maxScore\": 10, \"selfScore\": 0.5}, \"teacherTeamBuilding\": {\"content\": \"1111111111111111111111111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 0.5}, \"teachingProcessManagement\": {\"content\": \"111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 10}, \"teachingQualityManagement\": {\"content\": \"111111111111\", \"maxScore\": 10, \"selfScore\": 1}}, \"teachingOfficeId\": \"00000000-0000-0000-0000-000000000001\"}','submitted','2026-02-28 08:18:20','2026-02-28 08:18:20','2026-02-28 08:18:20',1),('552ef201-bc37-44e7-8e06-00fc55e0970e','00000000-0000-0000-0000-000000000001',2026,'{\"highlights\": {\"teachingHonors\": {\"items\": [], \"totalScore\": 0}, \"teachingCompetitions\": {\"items\": [], \"totalScore\": 0}, \"innovationCompetitions\": {\"items\": [], \"totalScore\": 0}, \"teachingReformProjects\": {\"items\": [], \"totalScore\": 0}}, \"negativeList\": {\"ideologyIssues\": {\"count\": 0, \"deduction\": 0}, \"ethicsViolations\": {\"count\": 0, \"deduction\": 0}, \"teachingAccidents\": {\"count\": 0, \"deduction\": 0}, \"workloadIncomplete\": {\"deduction\": 0, \"percentage\": 0}}, \"evaluationYear\": 2026, \"regularTeaching\": {\"courseAssessment\": {\"content\": \"11111111111111111111111\", \"maxScore\": 10, \"selfScore\": 1.5}, \"archiveManagement\": {\"content\": \"111111111111111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 1.5}, \"educationResearch\": {\"content\": \"1111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 1}, \"courseConstruction\": {\"content\": \"111111111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 1}, \"researchAndExchange\": {\"content\": \"1111111111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 1}, \"teacherTeamBuilding\": {\"content\": \"1111111111111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 1}, \"teachingProcessManagement\": {\"content\": \"1111111111111111\", \"maxScore\": 10, \"selfScore\": 2}, \"teachingQualityManagement\": {\"content\": \"111111111111111111111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 1.5}}, \"teachingOfficeId\": \"00000000-0000-0000-0000-000000000001\"}','submitted','2026-02-28 03:31:16','2026-02-28 03:30:45','2026-02-28 03:31:16',1),('5a25d98e-4046-4c4a-9fcf-06d5576307ec','00000000-0000-0000-0000-000000000001',2026,'{\"courseAssessment\": {\"content\": \"璇剧▼鑰冩牳宸ヤ綔鍐呭\", \"selfScore\": 8.0}, \"teachingProcessManagement\": {\"content\": \"鏁欏杩囩▼绠＄悊宸ヤ綔鍐呭\", \"selfScore\": 8.5}, \"teachingQualityManagement\": {\"content\": \"鏁欏璐ㄩ噺绠＄悊宸ヤ綔鍐呭\", \"selfScore\": 9.0}}','draft',NULL,'2026-02-28 09:32:02','2026-02-28 09:32:02',1),('5bfb3b63-17b3-4696-8aad-38ce3dc2134f','00000000-0000-0000-0000-000000000001',2026,'{\"highlights\": {\"teachingHonors\": {\"items\": [], \"totalScore\": 0}, \"teachingCompetitions\": {\"items\": [], \"totalScore\": 0}, \"innovationCompetitions\": {\"items\": [], \"totalScore\": 0}, \"teachingReformProjects\": {\"items\": [{\"name\": \"1111111111111111\", \"level\": \"national_key\", \"score\": 10}], \"totalScore\": 0}}, \"negativeList\": {\"ideologyIssues\": {\"count\": 0, \"deduction\": 0}, \"ethicsViolations\": {\"count\": 0, \"deduction\": 0}, \"teachingAccidents\": {\"count\": 1, \"deduction\": 5}, \"workloadIncomplete\": {\"deduction\": 0, \"percentage\": 0}}, \"evaluationYear\": 2026, \"regularTeaching\": {\"courseAssessment\": {\"content\": \"11111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 1}, \"archiveManagement\": {\"content\": \"11111111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 10}, \"educationResearch\": {\"content\": \"111111111111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 1}, \"courseConstruction\": {\"content\": \"1111111111111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 1}, \"researchAndExchange\": {\"content\": \"111111111111111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 10}, \"teacherTeamBuilding\": {\"content\": \"1111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 1}, \"teachingProcessManagement\": {\"content\": \"11111111111111\", \"maxScore\": 10, \"selfScore\": 1.5}, \"teachingQualityManagement\": {\"content\": \"111111111111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 0.5}}, \"teachingOfficeId\": \"00000000-0000-0000-0000-000000000001\"}','draft',NULL,'2026-02-18 03:05:19','2026-02-18 03:05:19',1),('6a129f43-7aff-4ab3-8f7d-98f2b303f516','00000000-0000-0000-0000-000000000001',2026,'{\"highlights\": {\"teachingHonors\": {\"items\": [], \"totalScore\": 0}, \"teachingCompetitions\": {\"items\": [], \"totalScore\": 0}, \"innovationCompetitions\": {\"items\": [], \"totalScore\": 0}, \"teachingReformProjects\": {\"items\": [{\"name\": \"1111111111111111111111111\", \"level\": \"national_key\", \"score\": 10}], \"totalScore\": 0}}, \"negativeList\": {\"ideologyIssues\": {\"count\": 0, \"deduction\": 0}, \"ethicsViolations\": {\"count\": 0, \"deduction\": 0}, \"teachingAccidents\": {\"count\": 1, \"deduction\": 5}, \"workloadIncomplete\": {\"deduction\": 0, \"percentage\": 0}}, \"evaluationYear\": 2026, \"regularTeaching\": {\"courseAssessment\": {\"content\": \"1111111111111111111111\", \"maxScore\": 10, \"selfScore\": 2}, \"archiveManagement\": {\"content\": \"111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 10}, \"educationResearch\": {\"content\": \"1111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 1.5}, \"courseConstruction\": {\"content\": \"1111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 1.5}, \"researchAndExchange\": {\"content\": \"111111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 10}, \"teacherTeamBuilding\": {\"content\": \"1111111111111111111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 1}, \"teachingProcessManagement\": {\"content\": \"1111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 1.5}, \"teachingQualityManagement\": {\"content\": \"111111111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 1.5}}, \"teachingOfficeId\": \"00000000-0000-0000-0000-000000000001\"}','submitted','2026-02-18 03:19:41','2026-02-18 03:19:41','2026-02-18 03:19:41',1),('74d19180-d003-4b24-8c16-34873a9b49e1','00000000-0000-0000-0000-000000000001',2026,'{\"highlights\": {\"teachingHonors\": {\"items\": [], \"totalScore\": 0}, \"teachingCompetitions\": {\"items\": [], \"totalScore\": 0}, \"innovationCompetitions\": {\"items\": [], \"totalScore\": 0}, \"teachingReformProjects\": {\"items\": [], \"totalScore\": 0}}, \"negativeList\": {\"ideologyIssues\": {\"count\": 0, \"deduction\": 0}, \"ethicsViolations\": {\"count\": 0, \"deduction\": 0}, \"teachingAccidents\": {\"count\": 0, \"deduction\": 0}, \"workloadIncomplete\": {\"deduction\": 0, \"percentage\": 0}}, \"evaluationYear\": 2026, \"regularTeaching\": {\"courseAssessment\": {\"content\": \"111111111111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 1}, \"archiveManagement\": {\"content\": \"1111111111111111111\", \"maxScore\": 10, \"selfScore\": 0}, \"educationResearch\": {\"content\": \"111111111111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 1}, \"courseConstruction\": {\"content\": \"11111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 1}, \"researchAndExchange\": {\"content\": \"1111111111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 1}, \"teacherTeamBuilding\": {\"content\": \"1111111111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 1}, \"teachingProcessManagement\": {\"content\": \"111111111111111\", \"maxScore\": 10, \"selfScore\": 1}, \"teachingQualityManagement\": {\"content\": \"1111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 1}}, \"teachingOfficeId\": \"a1b2c3d4-e5f6-4a5b-8c9d-111111111111\"}','submitted','2026-02-22 13:02:46','2026-02-22 13:02:46','2026-02-22 13:02:46',1),('a224bec2-e05a-449c-bc74-dc47353e7d74','00000000-0000-0000-0000-000000000001',2026,'{\"highlights\": {\"teachingHonors\": {\"items\": [], \"totalScore\": 0}, \"teachingCompetitions\": {\"items\": [], \"totalScore\": 0}, \"innovationCompetitions\": {\"items\": [], \"totalScore\": 0}, \"teachingReformProjects\": {\"items\": [], \"totalScore\": 0}}, \"negativeList\": {\"ideologyIssues\": {\"count\": 0, \"deduction\": 0}, \"ethicsViolations\": {\"count\": 0, \"deduction\": 0}, \"teachingAccidents\": {\"count\": 0, \"deduction\": 0}, \"workloadIncomplete\": {\"deduction\": 0, \"percentage\": 0}}, \"evaluationYear\": 2026, \"regularTeaching\": {\"courseAssessment\": {\"content\": \"1111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 0.5}, \"archiveManagement\": {\"content\": \"111111111111111111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 0.5}, \"educationResearch\": {\"content\": \"11111111111111111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 0.5}, \"courseConstruction\": {\"content\": \"1111111111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 0.5}, \"researchAndExchange\": {\"content\": \"11111111111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 0.5}, \"teacherTeamBuilding\": {\"content\": \"1111111111111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 0.5}, \"teachingProcessManagement\": {\"content\": \"111111111111111111111111111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 1}, \"teachingQualityManagement\": {\"content\": \"11111111111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 1}}, \"teachingOfficeId\": \"00000000-0000-0000-0000-000000000001\"}','submitted','2026-02-21 06:44:20','2026-02-21 06:43:49','2026-02-21 06:44:20',1),('a74ebde3-a983-4a70-a48d-df8a9f1b2053','00000000-0000-0000-0000-000000000001',2026,'{\"highlights\": {\"teachingHonors\": {\"items\": [], \"totalScore\": 0}, \"teachingCompetitions\": {\"items\": [], \"totalScore\": 0}, \"innovationCompetitions\": {\"items\": [], \"totalScore\": 0}, \"teachingReformProjects\": {\"items\": [], \"totalScore\": 0}}, \"negativeList\": {\"ideologyIssues\": {\"count\": 0, \"deduction\": 0}, \"ethicsViolations\": {\"count\": 0, \"deduction\": 0}, \"teachingAccidents\": {\"count\": 0, \"deduction\": 0}, \"workloadIncomplete\": {\"deduction\": 0, \"percentage\": 0}}, \"evaluationYear\": 2026, \"regularTeaching\": {\"courseAssessment\": {\"content\": \"222222222222222222222222222222222222222\", \"maxScore\": 10, \"selfScore\": 0.5}, \"archiveManagement\": {\"content\": \"2222222222222222222\", \"maxScore\": 10, \"selfScore\": 0.5}, \"educationResearch\": {\"content\": \"2222222222222222222222\", \"maxScore\": 10, \"selfScore\": 0.5}, \"courseConstruction\": {\"content\": \"2222222222222222222222222222222222222222222\", \"maxScore\": 10, \"selfScore\": 0.5}, \"researchAndExchange\": {\"content\": \"2222222222222222222222222\", \"maxScore\": 10, \"selfScore\": 0.5}, \"teacherTeamBuilding\": {\"content\": \"22222222222222222222222222\", \"maxScore\": 10, \"selfScore\": 0.5}, \"teachingProcessManagement\": {\"content\": \"2222222222222222222222222222222\", \"maxScore\": 10, \"selfScore\": 1}, \"teachingQualityManagement\": {\"content\": \"22222222222222222222222\", \"maxScore\": 10, \"selfScore\": 1}}, \"teachingOfficeId\": \"00000000-0000-0000-0000-000000000001\"}','submitted','2026-02-28 08:25:50','2026-02-28 08:25:49','2026-02-28 08:25:50',1),('b252b8cc-21d9-4024-a555-89215af459c6','00000000-0000-0000-0000-000000000001',2026,'{\"highlights\": {\"teachingHonors\": {\"items\": [], \"totalScore\": 0}, \"teachingCompetitions\": {\"items\": [], \"totalScore\": 0}, \"innovationCompetitions\": {\"items\": [], \"totalScore\": 0}, \"teachingReformProjects\": {\"items\": [], \"totalScore\": 0}}, \"negativeList\": {\"ideologyIssues\": {\"count\": 0, \"deduction\": 0}, \"ethicsViolations\": {\"count\": 0, \"deduction\": 0}, \"teachingAccidents\": {\"count\": 0, \"deduction\": 0}, \"workloadIncomplete\": {\"deduction\": 0, \"percentage\": 0}}, \"evaluationYear\": 2026, \"regularTeaching\": {\"courseAssessment\": {\"content\": \"1111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 0.5}, \"archiveManagement\": {\"content\": \"333333333333333333333333333333333333333\", \"maxScore\": 10, \"selfScore\": 0.5}, \"educationResearch\": {\"content\": \"11111111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 0.5}, \"courseConstruction\": {\"content\": \"111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 0.5}, \"researchAndExchange\": {\"content\": \"33333333333333333333\", \"maxScore\": 10, \"selfScore\": 0.5}, \"teacherTeamBuilding\": {\"content\": \"333333333333333333333333333\", \"maxScore\": 10, \"selfScore\": 0.5}, \"teachingProcessManagement\": {\"content\": \"11111111111111111111111\", \"maxScore\": 10, \"selfScore\": 0}, \"teachingQualityManagement\": {\"content\": \"1111111111\", \"maxScore\": 10, \"selfScore\": 0.5}}, \"teachingOfficeId\": \"00000000-0000-0000-0000-000000000001\"}','submitted','2026-02-28 08:42:57','2026-02-28 08:42:57','2026-02-28 08:42:57',1),('b445cb67-a5aa-4223-95bb-7cf3c57bc63d','00000000-0000-0000-0000-000000000001',2026,'{\"highlights\": {\"teachingHonors\": {\"items\": [], \"totalScore\": 0}, \"teachingCompetitions\": {\"items\": [], \"totalScore\": 0}, \"innovationCompetitions\": {\"items\": [], \"totalScore\": 0}, \"teachingReformProjects\": {\"items\": [], \"totalScore\": 0}}, \"negativeList\": {\"ideologyIssues\": {\"count\": 0, \"deduction\": 0}, \"ethicsViolations\": {\"count\": 0, \"deduction\": 0}, \"teachingAccidents\": {\"count\": 0, \"deduction\": 0}, \"workloadIncomplete\": {\"deduction\": 0, \"percentage\": 0}}, \"evaluationYear\": 2026, \"regularTeaching\": {\"courseAssessment\": {\"content\": \"eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee\", \"maxScore\": 10, \"selfScore\": 0}, \"archiveManagement\": {\"content\": \"eeeeeeeeeeeeeeeeeeeeeeeeee\", \"maxScore\": 10, \"selfScore\": 0}, \"educationResearch\": {\"content\": \"eeeeeeeeeeeeeeeeeeeeeeeee\", \"maxScore\": 10, \"selfScore\": 0}, \"courseConstruction\": {\"content\": \"eeeeeeeeeeeeeeeeeeeeeeeeeeeee\", \"maxScore\": 10, \"selfScore\": 0}, \"researchAndExchange\": {\"content\": \"eeeeeeeeeeeeeeeeeeeeeeeeee\", \"maxScore\": 10, \"selfScore\": 0}, \"teacherTeamBuilding\": {\"content\": \"eeeeeeeeeeeeee\", \"maxScore\": 10, \"selfScore\": 0}, \"teachingProcessManagement\": {\"content\": \"11111111111111111111111111111111111e\", \"maxScore\": 10, \"selfScore\": 0}, \"teachingQualityManagement\": {\"content\": \"eeeeeeeeeeeee\", \"maxScore\": 10, \"selfScore\": 0}}, \"teachingOfficeId\": \"00000000-0000-0000-0000-000000000001\"}','submitted','2026-02-28 17:35:53','2026-02-28 09:35:53','2026-02-28 17:35:53',1),('ccec9564-17ea-49ee-8fcf-33c875dd881d','00000000-0000-0000-0000-000000000002',2026,'{\"teamBuilding\": \"娴嬭瘯鍐呭\", \"honoraryAwards\": 1, \"studentGuidance\": \"娴嬭瘯鍐呭\", \"teachingQuality\": \"娴嬭瘯鍐呭\", \"courseConstruction\": \"娴嬭瘯鍐呭\", \"scientificResearch\": \"娴嬭瘯鍐呭\", \"teachingReformProjects\": 1, \"teachingProcessManagement\": \"娴嬭瘯鍐呭\"}','draft','2026-02-18 02:35:37','2026-02-18 02:35:35','2026-02-18 02:44:11',1),('d3d4d03f-d05e-46a3-b7fa-16f1d00721bc','00000000-0000-0000-0000-000000000001',2026,'{\"highlights\": {\"teachingHonors\": {\"items\": [], \"totalScore\": 0}, \"teachingCompetitions\": {\"items\": [], \"totalScore\": 0}, \"innovationCompetitions\": {\"items\": [], \"totalScore\": 0}, \"teachingReformProjects\": {\"items\": [], \"totalScore\": 0}}, \"negativeList\": {\"ideologyIssues\": {\"count\": 0, \"deduction\": 0}, \"ethicsViolations\": {\"count\": 0, \"deduction\": 0}, \"teachingAccidents\": {\"count\": 0, \"deduction\": 0}, \"workloadIncomplete\": {\"deduction\": 0, \"percentage\": 0}}, \"evaluationYear\": 2026, \"regularTeaching\": {\"courseAssessment\": {\"content\": \"11111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 0.5}, \"archiveManagement\": {\"content\": \"111111111111111111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 0.5}, \"educationResearch\": {\"content\": \"1111111111111111111\", \"maxScore\": 10, \"selfScore\": 0.5}, \"courseConstruction\": {\"content\": \"111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 0.5}, \"researchAndExchange\": {\"content\": \"11111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 0.5}, \"teacherTeamBuilding\": {\"content\": \"1111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 0.5}, \"teachingProcessManagement\": {\"content\": \"111111111111111111\", \"maxScore\": 10, \"selfScore\": 0.5}, \"teachingQualityManagement\": {\"content\": \"111111111111111111111\", \"maxScore\": 10, \"selfScore\": 0.5}}, \"teachingOfficeId\": \"00000000-0000-0000-0000-000000000001\"}','submitted','2026-02-28 17:10:37','2026-02-28 09:10:37','2026-02-28 17:10:37',1),('d46ffe3a-5948-41dc-ac06-1d31c54aadcd','00000000-0000-0000-0000-000000000001',2026,'{\"highlights\": {\"teachingHonors\": {\"items\": [], \"totalScore\": 0}, \"teachingCompetitions\": {\"items\": [], \"totalScore\": 0}, \"innovationCompetitions\": {\"items\": [], \"totalScore\": 0}, \"teachingReformProjects\": {\"items\": [], \"totalScore\": 0}}, \"negativeList\": {\"ideologyIssues\": {\"count\": 0, \"deduction\": 0}, \"ethicsViolations\": {\"count\": 0, \"deduction\": 0}, \"teachingAccidents\": {\"count\": 0, \"deduction\": 0}, \"workloadIncomplete\": {\"deduction\": 0, \"percentage\": 0}}, \"evaluationYear\": 2026, \"regularTeaching\": {\"courseAssessment\": {\"content\": \"111111111111111111\", \"maxScore\": 10, \"selfScore\": 0.5}, \"archiveManagement\": {\"content\": \"11111111111111111\", \"maxScore\": 10, \"selfScore\": 0.5}, \"educationResearch\": {\"content\": \"1111111111111\", \"maxScore\": 10, \"selfScore\": 0}, \"courseConstruction\": {\"content\": \"111111111111111\", \"maxScore\": 10, \"selfScore\": 0.5}, \"researchAndExchange\": {\"content\": \"111111111111111111\", \"maxScore\": 10, \"selfScore\": 0.5}, \"teacherTeamBuilding\": {\"content\": \"1111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 0.5}, \"teachingProcessManagement\": {\"content\": \"1111111111111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 0.5}, \"teachingQualityManagement\": {\"content\": \"11111111111111111111111\", \"maxScore\": 10, \"selfScore\": 1}}, \"teachingOfficeId\": \"00000000-0000-0000-0000-000000000001\"}','submitted','2026-02-18 03:07:29','2026-02-18 03:07:29','2026-02-18 03:07:29',1),('d922392d-38cd-40df-911d-c114f84bc4d2','00000000-0000-0000-0000-000000000001',2026,'{\"highlights\": {\"teachingHonors\": {\"items\": [{\"name\": \"1111111111111111111111\", \"level\": \"provincial\", \"score\": 5}], \"totalScore\": 0}, \"teachingCompetitions\": {\"items\": [{\"name\": \"1111111111111111111111111\", \"score\": 8, \"levelPrize\": \"national_second\"}], \"totalScore\": 0}, \"innovationCompetitions\": {\"items\": [{\"name\": \"111111111111111111111111111111111\", \"score\": 10, \"levelPrize\": \"national_gold\"}], \"totalScore\": 0}, \"teachingReformProjects\": {\"items\": [{\"name\": \"11111111111111111\", \"level\": \"national_key\", \"score\": 10}], \"totalScore\": 0}}, \"negativeList\": {\"ideologyIssues\": {\"count\": 1, \"deduction\": 5}, \"ethicsViolations\": {\"count\": 1, \"deduction\": 10}, \"teachingAccidents\": {\"count\": 1, \"deduction\": 5}, \"workloadIncomplete\": {\"deduction\": 0, \"percentage\": 1}}, \"evaluationYear\": 2026, \"regularTeaching\": {\"courseAssessment\": {\"content\": \"11111111111111111111\", \"maxScore\": 10, \"selfScore\": 10}, \"archiveManagement\": {\"content\": \"111111111111111111\", \"maxScore\": 10, \"selfScore\": 10}, \"educationResearch\": {\"content\": \"11111111111111111111111\", \"maxScore\": 10, \"selfScore\": 10}, \"courseConstruction\": {\"content\": \"111111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 10}, \"researchAndExchange\": {\"content\": \"1111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 10}, \"teacherTeamBuilding\": {\"content\": \"1111111111111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 10}, \"teachingProcessManagement\": {\"content\": \"11111111111111\", \"maxScore\": 10, \"selfScore\": 10}, \"teachingQualityManagement\": {\"content\": \"1111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 10}}, \"teachingOfficeId\": \"00000000-0000-0000-0000-000000000001\"}','submitted','2026-02-28 08:07:33','2026-02-28 08:07:33','2026-02-28 08:07:33',1),('dd211726-ef92-4fd1-a469-3d279fd02f1e','00000000-0000-0000-0000-000000000001',2033,'{\"regularTeaching\": {\"teachingProcessManagement\": {\"content\": \"test content\", \"selfScore\": 8}}}','locked','2026-02-15 08:45:26','2026-02-15 08:45:22','2026-02-15 08:45:26',1),('e23d5d72-ba87-4eb8-bcc4-7f56a21bac18','00000000-0000-0000-0000-000000000001',2025,'{\"teamBuilding\": \"娴嬭瘯鍐呭\", \"honoraryAwards\": 1, \"studentGuidance\": \"娴嬭瘯鍐呭\", \"teachingQuality\": \"娴嬭瘯鍐呭\", \"courseConstruction\": \"娴嬭瘯鍐呭\", \"scientificResearch\": \"娴嬭瘯鍐呭\", \"teachingReformProjects\": 1, \"teachingProcessManagement\": \"娴嬭瘯鍐呭\"}','draft',NULL,'2026-02-18 02:29:51','2026-02-18 02:29:51',1),('e56d8557-e341-40ff-9987-1ca7d50d21c7','a1b2c3d4-e5f6-4a5b-8c9d-111111111111',2026,'{\"highlights\": {\"teachingHonors\": {\"items\": [], \"totalScore\": 0}, \"teachingCompetitions\": {\"items\": [], \"totalScore\": 0}, \"innovationCompetitions\": {\"items\": [], \"totalScore\": 0}, \"teachingReformProjects\": {\"items\": [], \"totalScore\": 0}}, \"negativeList\": {\"ideologyIssues\": {\"count\": 0, \"deduction\": 0}, \"ethicsViolations\": {\"count\": 0, \"deduction\": 0}, \"teachingAccidents\": {\"count\": 0, \"deduction\": 0}, \"workloadIncomplete\": {\"deduction\": 0, \"percentage\": 0}}, \"evaluationYear\": 2026, \"regularTeaching\": {\"courseAssessment\": {\"content\": \"111111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 0}, \"archiveManagement\": {\"content\": \"111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 10}, \"educationResearch\": {\"content\": \"111111111111111111\", \"maxScore\": 10, \"selfScore\": 4}, \"courseConstruction\": {\"content\": \"1111111111111111111\", \"maxScore\": 10, \"selfScore\": 4}, \"researchAndExchange\": {\"content\": \"11111111111111111111\", \"maxScore\": 10, \"selfScore\": 8.5}, \"teacherTeamBuilding\": {\"content\": \"11111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 6}, \"teachingProcessManagement\": {\"content\": \"111111111111111\", \"maxScore\": 10, \"selfScore\": 3.5}, \"teachingQualityManagement\": {\"content\": \"11111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 1}}, \"teachingOfficeId\": \"a1b2c3d4-e5f6-4a5b-8c9d-111111111111\"}','draft','2026-02-13 14:16:31','2026-02-13 14:16:31','2026-02-18 02:45:43',1),('f6678240-e2cb-4f46-ac31-6735fb9047a4','00000000-0000-0000-0000-000000000001',2026,'{\"highlights\": {\"teachingHonors\": {\"items\": [], \"totalScore\": 0}, \"teachingCompetitions\": {\"items\": [], \"totalScore\": 0}, \"innovationCompetitions\": {\"items\": [], \"totalScore\": 0}, \"teachingReformProjects\": {\"items\": [], \"totalScore\": 0}}, \"negativeList\": {\"ideologyIssues\": {\"count\": 0, \"deduction\": 0}, \"ethicsViolations\": {\"count\": 0, \"deduction\": 0}, \"teachingAccidents\": {\"count\": 0, \"deduction\": 0}, \"workloadIncomplete\": {\"deduction\": 0, \"percentage\": 0}}, \"evaluationYear\": 2026, \"regularTeaching\": {\"courseAssessment\": {\"content\": \"111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 1}, \"archiveManagement\": {\"content\": \"111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 3}, \"educationResearch\": {\"content\": \"11111111111111111111111111111111111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 1}, \"courseConstruction\": {\"content\": \"111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 1}, \"researchAndExchange\": {\"content\": \"1111111111111111111\", \"maxScore\": 10, \"selfScore\": 3.5}, \"teacherTeamBuilding\": {\"content\": \"111111111111111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 1}, \"teachingProcessManagement\": {\"content\": \"1111111111111111111111\", \"maxScore\": 10, \"selfScore\": 1.5}, \"teachingQualityManagement\": {\"content\": \"11111111111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 1}}, \"teachingOfficeId\": \"00000000-0000-0000-0000-000000000001\"}','submitted','2026-02-18 02:52:29','2026-02-18 02:52:29','2026-02-18 02:52:29',1),('f73821c7-a6e5-47d5-8120-cf5b45b1d4dd','00000000-0000-0000-0000-000000000001',2024,'{\"regularTeaching\": {\"teachingProcessManagement\": {\"content\": \"娴嬭瘯鍐呭\", \"selfScore\": 8}}}','locked','2026-02-15 08:44:35','2026-02-15 08:44:01','2026-02-15 08:44:35',1),('faa49cfd-090d-4d36-82ac-53c302e6e6e8','00000000-0000-0000-0000-000000000001',2026,'{\"highlights\": {\"teachingHonors\": {\"items\": [], \"totalScore\": 0}, \"teachingCompetitions\": {\"items\": [], \"totalScore\": 0}, \"innovationCompetitions\": {\"items\": [], \"totalScore\": 0}, \"teachingReformProjects\": {\"items\": [], \"totalScore\": 0}}, \"negativeList\": {\"ideologyIssues\": {\"count\": 0, \"deduction\": 0}, \"ethicsViolations\": {\"count\": 0, \"deduction\": 0}, \"teachingAccidents\": {\"count\": 0, \"deduction\": 0}, \"workloadIncomplete\": {\"deduction\": 0, \"percentage\": 0}}, \"evaluationYear\": 2026, \"regularTeaching\": {\"courseAssessment\": {\"content\": \"111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 3}, \"archiveManagement\": {\"content\": \"11111111111111111111111\", \"maxScore\": 10, \"selfScore\": 3}, \"educationResearch\": {\"content\": \"1111111111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 3.5}, \"courseConstruction\": {\"content\": \"11111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 3}, \"researchAndExchange\": {\"content\": \"11111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 2.5}, \"teacherTeamBuilding\": {\"content\": \"1111111111111\", \"maxScore\": 10, \"selfScore\": 2}, \"teachingProcessManagement\": {\"content\": \"11111111111111111111111111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 0.5}, \"teachingQualityManagement\": {\"content\": \"11111111111111111111111111111111111\", \"maxScore\": 10, \"selfScore\": 1}}, \"teachingOfficeId\": \"00000000-0000-0000-0000-000000000001\"}','draft','2026-02-14 02:40:33','2026-02-14 02:28:36','2026-02-18 02:45:41',1);
/*!40000 ALTER TABLE `self_evaluations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sync_tasks`
--

DROP TABLE IF EXISTS `sync_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sync_tasks` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `evaluation_ids` json NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `synced_count` int NOT NULL,
  `failed_count` int NOT NULL,
  `total_count` int NOT NULL,
  `started_at` datetime NOT NULL,
  `completed_at` datetime DEFAULT NULL,
  `error_message` text COLLATE utf8mb4_unicode_ci,
  `retry_count` int NOT NULL,
  `checksum` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sync_data` json DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sync_tasks`
--

LOCK TABLES `sync_tasks` WRITE;
/*!40000 ALTER TABLE `sync_tasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `sync_tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teaching_offices`
--

DROP TABLE IF EXISTS `teaching_offices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teaching_offices` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `department` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `college_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_teaching_offices_code` (`code`),
  KEY `college_id` (`college_id`),
  CONSTRAINT `teaching_offices_ibfk_1` FOREIGN KEY (`college_id`) REFERENCES `colleges` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teaching_offices`
--

LOCK TABLES `teaching_offices` WRITE;
/*!40000 ALTER TABLE `teaching_offices` DISABLE KEYS */;
INSERT INTO `teaching_offices` VALUES ('00000000-0000-0000-0000-000000000001','Computer Science Office','CS001','Computer Department',NULL,'2026-02-14 09:58:21','2026-02-14 09:58:21'),('00000000-0000-0000-0000-000000000002','Mathematics Office','MATH001','Math Department',NULL,'2026-02-14 09:58:21','2026-02-14 09:58:21'),('00000000-0000-0000-0000-000000000003','Physics Office','PHY001','Physics Department',NULL,'2026-02-14 09:58:21','2026-02-14 09:58:21'),('a1b2c3d4-e5f6-4a5b-8c9d-111111111111','Test Teaching Office','TEST001','Test Department',NULL,'2026-02-13 20:56:19','2026-02-13 20:56:19');
/*!40000 ALTER TABLE `teaching_offices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `teaching_office_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `college_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_users_username` (`username`),
  KEY `college_id` (`college_id`),
  KEY `teaching_office_id` (`teaching_office_id`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`college_id`) REFERENCES `colleges` (`id`),
  CONSTRAINT `users_ibfk_2` FOREIGN KEY (`teaching_office_id`) REFERENCES `teaching_offices` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('10000000-0000-0000-0000-000000000001','director1','$2b$12$pUnSwqQJDx2I8f0SklsRCOMuuHQzED9NGFFXIVDIaDkUyN67AvZd6','teaching_office','00000000-0000-0000-0000-000000000001',NULL,'Director Zhang','director1@example.com','2026-02-14 09:58:21','2026-02-14 09:58:21'),('10000000-0000-0000-0000-000000000002','director2','$2b$12$pUnSwqQJDx2I8f0SklsRCOMuuHQzED9NGFFXIVDIaDkUyN67AvZd6','teaching_office','00000000-0000-0000-0000-000000000002',NULL,'Director Li','director2@example.com','2026-02-14 09:58:21','2026-02-14 09:58:21'),('10000000-0000-0000-0000-000000000003','director3','$2b$12$pUnSwqQJDx2I8f0SklsRCOMuuHQzED9NGFFXIVDIaDkUyN67AvZd6','teaching_office','00000000-0000-0000-0000-000000000003',NULL,'Director Wang','director3@example.com','2026-02-14 09:58:21','2026-02-14 09:58:21'),('20000000-0000-0000-0000-000000000001','evaluator1','$2b$12$pUnSwqQJDx2I8f0SklsRCOMuuHQzED9NGFFXIVDIaDkUyN67AvZd6','evaluation_team',NULL,NULL,'Evaluator Zhang','evaluator1@example.com','2026-02-14 09:58:21','2026-02-14 09:58:21'),('20000000-0000-0000-0000-000000000002','evaluator2','$2b$12$pUnSwqQJDx2I8f0SklsRCOMuuHQzED9NGFFXIVDIaDkUyN67AvZd6','evaluation_team',NULL,NULL,'Evaluator Li','evaluator2@example.com','2026-02-14 09:58:21','2026-02-14 09:58:21'),('30000000-0000-0000-0000-000000000001','office1','$2b$12$pUnSwqQJDx2I8f0SklsRCOMuuHQzED9NGFFXIVDIaDkUyN67AvZd6','evaluation_office',NULL,NULL,'Office Director','office1@example.com','2026-02-14 09:58:21','2026-02-14 09:58:21'),('40000000-0000-0000-0000-000000000001','president1','$2b$12$pUnSwqQJDx2I8f0SklsRCOMuuHQzED9NGFFXIVDIaDkUyN67AvZd6','president_office',NULL,NULL,'President','president1@example.com','2026-02-14 09:58:21','2026-02-14 09:58:21'),('a1b2c3d4-e5f6-4a5b-8c9d-0e1f2a3b4c5d','123','$2b$12$pUnSwqQJDx2I8f0SklsRCOMuuHQzED9NGFFXIVDIaDkUyN67AvZd6','teaching_office','a1b2c3d4-e5f6-4a5b-8c9d-111111111111',NULL,'Teaching Office User','teaching123@test.com','2026-02-13 20:45:29','2026-02-13 21:21:58'),('b2c3d4e5-f6a7-4b5c-9d0e-1f2a3b4c5d6e','admin','$2b$12$pUnSwqQJDx2I8f0SklsRCOMuuHQzED9NGFFXIVDIaDkUyN67AvZd6','evaluation_team',NULL,NULL,'Evaluation Team User','admin123@test.com','2026-02-13 20:45:29','2026-02-13 21:21:58');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-04 14:40:55
