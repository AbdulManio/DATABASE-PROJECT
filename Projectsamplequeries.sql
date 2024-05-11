-- 1. Retrieve all users from a specific country (e.g., USA):
use vrgames;
SELECT * FROM Users WHERE country = 'USA';

-- 2. Retrieve all games developed by a specific developer (e.g., Ubisoft):
SELECT * FROM Games WHERE Developerid = (SELECT DeveloperId FROM Developer WHERE DEV_NAME = 'Ubisoft');

-- 3. Retrieve all reviews for a specific game (e.g., Grand Theft Auto V):
SELECT * FROM Reviews WHERE gameID = (SELECT GameID FROM Games WHERE gametitle = 'Grand Theft Auto V');

-- 4. Retrieve the average rating for a specific game (e.g., The Last of Us Part II):

SELECT AVG(rating) AS average_rating FROM Reviews WHERE gameID = (SELECT GameID FROM Games WHERE gametitle = 'The Last of Us Part II');

-- 5. Retrieve the total number of downloads for a specific game (e.g., Minecraft):
SELECT SUM(NO_of_Downloads) AS total_downloads FROM Games WHERE gametitle = 'Minecraft';

-- 6. Retrieve the total amount spent by a specific user (e.g., user with USERID 6):
SELECT SUM(Amount) AS total_amount_spent FROM Transactions WHERE userID = 6;

-- 7. Retrieve the total duration played by a specific user (e.g., user with USERID 10):
SELECT SUM(Duration) AS total_duration_played FROM GamePlayData WHERE userID = 10;

-- 8. Retrieve the most popular genre among the games:
SELECT genre, COUNT(*) AS num_games FROM Games GROUP BY genre ORDER BY num_games DESC LIMIT 1;

-- 9. Retrieve the number of games added to the wishlist by each user:
SELECT userID, COUNT(*) AS num_games_wishlist FROM Wishlist GROUP BY userID;

-- 10. Retrieve the subscription status of a specific user (e.g., user with USERID 1):
SELECT subscription_status FROM user_status WHERE USERID = 1;

-- 11. Find all games developed by Ubisoft and their average rating:
SELECT g.gametitle, g.avg_rating
FROM Games g
JOIN Developer d ON g.Developerid = d.DeveloperId
WHERE d.DEV_NAME = 'Ubisoft';

-- 12. List all users who have subscribed but haven't made any transactions:
SELECT u.Username
FROM Users u
LEFT JOIN Transactions t ON u.USERID = t.userID
JOIN user_status us ON u.USERID = us.USERID
WHERE us.subscription_status = 'Active' AND t.TransactionID IS NULL;

-- 13. Count the number of games in each genre:
SELECT genre, COUNT(*) AS game_count
FROM Games
GROUP BY genre;

-- 14. Calculate the total amount spent by each user on transactions:
SELECT u.Username, SUM(t.Amount) AS total_spent
FROM Users u
LEFT JOIN Transactions t ON u.USERID = t.userID
GROUP BY u.Username;

-- 15. Find the top 3 most downloaded games:
SELECT gametitle, NO_of_Downloads
FROM Games
ORDER BY NO_of_Downloads DESC
LIMIT 3;

-- 16. List the users who have rated games but haven't subscribed:
SELECT DISTINCT u.Username
FROM Users u
LEFT JOIN Reviews r ON u.USERID = r.userID
LEFT JOIN user_status us ON u.USERID = us.USERID
WHERE r.reviewID IS NOT NULL AND us.subscription_status = 'Inactive';

-- 17. Find the average duration of gameplay sessions for each game:
SELECT g.gametitle, SEC_TO_TIME(AVG(TIME_TO_SEC(gd.Duration))) AS avg_session_duration
FROM Games g
JOIN GamePlayData gd ON g.GameID = gd.gameID
GROUP BY g.gametitle;

-- 18. Calculate the total score achieved by each user in gameplay sessions:
SELECT u.Username, SUM(gd.Score) AS total_score
FROM Users u
JOIN GamePlayData gd ON u.USERID = gd.userID
GROUP BY u.Username;

-- 19. List the games along with the count of users who have added them to their wishlist:
SELECT g.gametitle, COUNT(w.userID) AS wishlist_count
FROM Games g
LEFT JOIN Wishlist w ON g.GameID = w.gameID
GROUP BY g.gametitle;

-- 20. list all the users in ascending order of their names
SELECT Username
FROM Users
ORDER BY Username ASC;









