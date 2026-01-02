-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 01, 2026 at 07:43 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `healthy_meal_planner`
--

-- --------------------------------------------------------

--
-- Table structure for table `about_page`
--

CREATE TABLE `about_page` (
  `id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `main_description` text DEFAULT NULL,
  `secondary_description` text DEFAULT NULL,
  `philosophy_title` varchar(150) DEFAULT NULL,
  `philosophy_quote` varchar(255) DEFAULT NULL,
  `button_text` varchar(100) DEFAULT NULL,
  `button_link` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `about_page`
--

INSERT INTO `about_page` (`id`, `title`, `main_description`, `secondary_description`, `philosophy_title`, `philosophy_quote`, `button_text`, `button_link`, `image`) VALUES
(1, 'Redefine your mealtime', 'NutriPlan isn’t just a meal planner — it’s your daily partner for mindful eating. We blend smart technology with nutritional balance to make healthy living a lifestyle, not a challenge.', 'From tailored plans to inspiring recipes, NutriPlan helps you stay consistent, save time, and enjoy every bite with confidence.', 'Our Philosophy', 'Small choices every day lead to a healthier,happier you.', 'Start Your Journey', '#planner', 'About.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `name`) VALUES
(1, 'breakfast'),
(3, 'dinner'),
(2, 'lunch'),
(5, 'salad'),
(6, 'smoothie'),
(4, 'snack');

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE `contact` (
  `contact_id` int(11) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `location` varchar(255) NOT NULL,
  `map_image` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contact`
--

INSERT INTO `contact` (`contact_id`, `phone`, `email`, `location`, `map_image`) VALUES
(5, '+961 76 123 456', 'hello@nutriplan.com', 'Beirut', 'map.jpg_1767131655594.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `contact_messages`
--

CREATE TABLE `contact_messages` (
  `message_id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_read` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contact_messages`
--

INSERT INTO `contact_messages` (`message_id`, `name`, `email`, `message`, `created_at`, `is_read`) VALUES
(2, 'waad', 'waad@gmail.com', 'Can you please reply to my emails?', '2025-12-30 22:13:25', 1),
(3, 'Ali Hamdan', 'alih@gmail.com', 'Do you have vegetarian meal options?', '2025-12-31 11:49:59', 1),
(4, 'Omar Saleh', 'omar12@email.com', 'I’m having trouble logging into my account. The password reset email is not arriving. Could you assist me?', '2025-12-31 11:51:15', 1);

-- --------------------------------------------------------

--
-- Table structure for table `meal_plans`
--

CREATE TABLE `meal_plans` (
  `plan_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `plan_type` enum('daily','weekly') NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `meal_plan_items`
--

CREATE TABLE `meal_plan_items` (
  `item_id` int(11) NOT NULL,
  `meal_plan_id` int(11) NOT NULL,
  `recipe_id` int(11) NOT NULL,
  `meal_time_id` int(11) NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `meal_times`
--

CREATE TABLE `meal_times` (
  `meal_time_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `meal_times`
--

INSERT INTO `meal_times` (`meal_time_id`, `name`) VALUES
(1, 'breakfast'),
(3, 'dinner'),
(2, 'lunch'),
(5, 'salad'),
(4, 'snack');

-- --------------------------------------------------------

--
-- Table structure for table `recipes`
--

CREATE TABLE `recipes` (
  `recipe_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `calories` int(11) DEFAULT NULL,
  `protein` int(11) DEFAULT NULL,
  `carbs` int(11) DEFAULT NULL,
  `fats` int(11) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `recipes`
--

INSERT INTO `recipes` (`recipe_id`, `name`, `description`, `calories`, `protein`, `carbs`, `fats`, `image`, `category_id`) VALUES
(1, 'Avocado Toast', 'A nutritious toast topped with creamy avocado, perfect for an energizing morning.', 320, 15, 8, 9, 'Breakfast2.jpg_1767126807221.jpg', 1),
(2, 'Halloumi Toast', 'Crispy toast layered with grilled halloumi cheese for a savory breakfast option.', 380, 15, 10, 13, 'Breakfast.jpg', 1),
(3, 'Fruit Bowl', 'A refreshing bowl of mixed fruits rich in vitamins and natural sweetness.', 250, 25, 2, 5, 'Breakfast3.jpg', 1),
(4, 'Greek Yogurt Bowl', 'Creamy Greek yogurt topped with granola and berries for a high-protein breakfast.', 300, 30, 6, 8, 'Breakfast4.jpg', 1),
(5, 'Scrambled Eggs', 'Soft and fluffy scrambled eggs made in minutes.', 220, 15, 3, 5, 'Dinner1.jpg', 3),
(6, 'Spinach Eggs', 'Eggs cooked with fresh spinach for a nutrient-rich dinner.', 250, 24, 5, 10, 'Dinner3.jpg', 3),
(7, 'Cheese Toast', 'Toasted bread topped with melty cheese—simple and satisfying.', 300, 20, 15, 10, 'Dinner5.jpg', 3),
(8, 'Chicken Sandwich', 'A high-protein grilled chicken sandwich packed with flavor.', 420, 35, 20, 18, 'Lunch3.jpg', 2),
(9, 'Steak with Mashed Potato', 'Juicy steak served with creamy mashed potatoes.', 550, 40, 25, 18, 'Lunch2.jpg', 2),
(10, 'Baked Salmon', 'Tender baked salmon rich in omega-3 fatty acids.', 480, 35, 5, 5, 'Lunch8.jpg', 2),
(11, 'Taboule', 'A refreshing Middle Eastern parsley salad full of flavor.', 200, 6, 0, 0, 'Salad7.jpg', 5),
(12, 'Potato Salad', 'Creamy potato salad with light dressing.', 260, 6, 0, 0, 'Salad2.jpg', 5),
(13, 'Shrimp Salad', 'A refreshing salad with shrimp, lettuce, and avocado.', 300, 6, 0, 5, 'Salad5.jpg', 5),
(14, 'Apple with Cinnamon', 'A light and naturally sweet snack with warm cinnamon flavor.', 120, 15, 8, 5, 'Snack4.jpg', 4),
(15, 'Granola Bar', 'A wholesome oat bar perfect for quick energy.', 200, 15, 8, 8, 'Snack9.jpg', 4),
(16, 'Frozen Greek Yogurt Chocolate', 'A low-calorie frozen yogurt dessert with chocolate flavor.', 150, 10, 5, 2, 'Snack7.jpg', 4),
(17, 'Pineapple Smoothie', 'A refreshing pineapple smoothie that aids digestion.', 200, 10, 5, 5, 'Smoothie2.jpg', 6),
(18, 'Kiwi Smoothie', 'A vitamin-rich kiwi smoothie packed with freshness.', 180, 12, 3, 5, 'Smoothie3.jpg', 6),
(19, 'Mixed Fruits Smoothie', 'A delicious blend of fresh fruits for a healthy drink.', 220, 20, 4, 6, 'Smoothie6.jpg', 6),
(20, 'Rice with Chicken', 'Flavorful chicken served with perfectly cooked rice.', 520, 35, 20, 10, 'Lunch7.jpg', 2);

-- --------------------------------------------------------

--
-- Table structure for table `testimonials`
--

CREATE TABLE `testimonials` (
  `testimonial_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `text` text NOT NULL,
  `rating` int(11) DEFAULT NULL CHECK (`rating` between 1 and 5),
  `image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `testimonials`
--

INSERT INTO `testimonials` (`testimonial_id`, `name`, `text`, `rating`, `image`) VALUES
(1, 'Layla H.', 'NutriPlan completely changed how I eat! The meals are healthy, delicious, and perfectly balanced.', 5, 'person1.jpg'),
(2, 'Omar K.', 'I love how easy it is to plan my meals. I’ve lost 5kg in 2 months without feeling restricted!', 4, 'person2.jpg'),
(5, 'Sara M.', 'I love how easy it is to plan my meals. I’ve lost 5kg in 2 months without feeling restricted!', 5, 'person3.jpg_1767103595055.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `UserID` int(11) NOT NULL,
  `Username` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `role` varchar(100) DEFAULT 'client'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`UserID`, `Username`, `password`, `Email`, `role`) VALUES
(1, 'waad', '11', 'waadbusiness35@gmail.com', 'client'),
(2, 'Admin', '3535', 'waad@gmail.com', 'admin'),
(4, 'hibaelali', '1212', 'hibaelali@gmail.com', 'client'),
(7, 'abd', 'abd1', 'abd@gmail.com', 'client'),
(11, 'Abdallah', 'abd', 'abdallah@gmail.com', 'client'),
(13, 'ali', '35123', 'ali@gmail.com', 'client'),
(14, 'katya', '12345', 'katya@email.com', 'client'),
(23, 'waad', 'waad123', 'waadelali0@gmail.com', 'client'),
(24, 'waad', 'www', 'waadelali0@gmail.com', 'client'),
(25, 'waad', 'abcd', 'waad3333@gmail.com', 'client'),
(28, 'Waad', 'waad', 'waaad@email.com', 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `why_choose_us`
--

CREATE TABLE `why_choose_us` (
  `reason_id` int(11) NOT NULL,
  `icon` varchar(100) DEFAULT NULL,
  `title` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `order_number` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `why_choose_us`
--

INSERT INTO `why_choose_us` (`reason_id`, `icon`, `title`, `description`, `order_number`) VALUES
(1, 'LocalDining', 'Personalized Meal Plans', 'Smart and balanced plans tailored to your health goals and preferences.', 1),
(2, 'Favorite ', 'Healthy & Delicious', 'Enjoy meals that are both nutritious and full of flavor — no compromises.', 2),
(3, 'AccessTime ', 'Save Time & Stay Consistent', 'No more guessing what to eat — NutriPlan keeps you organized effortlessly.', 3),
(4, 'EmojiEmotions ', 'Feel Great Every Day', 'Experience more energy, better focus, and an overall improved lifestyle.', 4);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `about_page`
--
ALTER TABLE `about_page`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`contact_id`);

--
-- Indexes for table `contact_messages`
--
ALTER TABLE `contact_messages`
  ADD PRIMARY KEY (`message_id`);

--
-- Indexes for table `meal_plans`
--
ALTER TABLE `meal_plans`
  ADD PRIMARY KEY (`plan_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `meal_plan_items`
--
ALTER TABLE `meal_plan_items`
  ADD PRIMARY KEY (`item_id`),
  ADD KEY `meal_plan_id` (`meal_plan_id`),
  ADD KEY `recipe_id` (`recipe_id`),
  ADD KEY `meal_time_id` (`meal_time_id`);

--
-- Indexes for table `meal_times`
--
ALTER TABLE `meal_times`
  ADD PRIMARY KEY (`meal_time_id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `recipes`
--
ALTER TABLE `recipes`
  ADD PRIMARY KEY (`recipe_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `testimonials`
--
ALTER TABLE `testimonials`
  ADD PRIMARY KEY (`testimonial_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`UserID`);

--
-- Indexes for table `why_choose_us`
--
ALTER TABLE `why_choose_us`
  ADD PRIMARY KEY (`reason_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `about_page`
--
ALTER TABLE `about_page`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `contact`
--
ALTER TABLE `contact`
  MODIFY `contact_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `contact_messages`
--
ALTER TABLE `contact_messages`
  MODIFY `message_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `meal_plans`
--
ALTER TABLE `meal_plans`
  MODIFY `plan_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `meal_plan_items`
--
ALTER TABLE `meal_plan_items`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `meal_times`
--
ALTER TABLE `meal_times`
  MODIFY `meal_time_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `recipes`
--
ALTER TABLE `recipes`
  MODIFY `recipe_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `testimonials`
--
ALTER TABLE `testimonials`
  MODIFY `testimonial_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `why_choose_us`
--
ALTER TABLE `why_choose_us`
  MODIFY `reason_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `meal_plans`
--
ALTER TABLE `meal_plans`
  ADD CONSTRAINT `meal_plans_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`UserID`) ON DELETE CASCADE;

--
-- Constraints for table `meal_plan_items`
--
ALTER TABLE `meal_plan_items`
  ADD CONSTRAINT `meal_plan_items_ibfk_1` FOREIGN KEY (`meal_plan_id`) REFERENCES `meal_plans` (`plan_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `meal_plan_items_ibfk_2` FOREIGN KEY (`recipe_id`) REFERENCES `recipes` (`recipe_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `meal_plan_items_ibfk_3` FOREIGN KEY (`meal_time_id`) REFERENCES `meal_times` (`meal_time_id`);

--
-- Constraints for table `recipes`
--
ALTER TABLE `recipes`
  ADD CONSTRAINT `recipes_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
