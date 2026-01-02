const express = require("express");
const cors = require("cors");
const mysql = require("mysql2");
const multer = require("multer");
const path = require("path");
const app = express();
const PORT = process.env.PORT || 5000;
require("dotenv").config();
app.use(cors());
app.use(express.json());
app.use("/images", express.static("images"));


// DB
const db = mysql.createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASS, // empty string
  database: process.env.DB_NAME,
  port:process.env.DB_PORT
});

db.connect((err) => {
  if (err) throw err;
  console.log("Connected to MySQL!");

  const sql = fs.readFileSync("import.sql").toString();
  db.query(sql, (err, result) => {
    if (err) throw err;
    console.log("SQL imported successfully!");
    db.end();
  });
});
// TEST
app.get("/", (req, res) => {
  res.send("Backend is running!");
});

// REGISTER
app.post("/register", (req, res) => {
  const { username, password, email } = req.body;
  const q =
    "INSERT INTO users (Username, password, Email) VALUES (?, ?, ?)";

  db.query(q, [username, password, email], (err) => {
    if (err) return res.status(500).json(err);
    res.json("Registered successfully");
  });
});

// LOGIN  ✅
app.post("/login", (req, res) => {
  const { username, password } = req.body;
  const q = "SELECT * FROM users WHERE Username = ? AND password = ?";

  db.query(q, [username, password], (err, data) => {
    if (err) return res.status(500).json(err);
    if (data.length === 0)
      return res.status(400).send("Wrong username or password");

    // ⬅️ get role + username back
    res.json({
      role: data[0].role,
      username: data[0].Username
    });
  });
});
// GET all users
app.get("/admin/users", (req, res) => {
  const q = "SELECT UserID, Username, Email, role FROM users";
  db.query(q, (err, data) => {
    if (err) return res.status(500).json(err);
    res.json(data);
  });
});

// UPDATE user info
app.put("/admin/users/update/:id", (req, res) => {
  const { username , email, password,role } = req.body;
  const { id } = req.params;
  const q = "UPDATE users SET Username=?, Email=?,password=?, role=? WHERE UserID=?";
  db.query(q, [username, email,password,role, id], (err,data) => {
    if (err) return res.status(500).json(err);
    res.json(data);
  });
});
// ADD user
app.post("/admin/users/add", (req, res) => {
const { username , email, password,role } = req.body;
const q =
"INSERT INTO users(`Username`,`Email`,`password`,`role`) VALUES (?, ?, ? , ?)";
db.query(q, [username, email,password, role], (err, data) => {
if (err) return res.send(err);
return res.json(data);
});
});
// DELETE user
app.delete("/admin/users/delete/:id", (req, res) => {
 const id = req.params.id;
  const q = "DELETE FROM users WHERE UserID=?";
  db.query(q, [id], (err,data) => {
    if (err) return res.status(500).json(err);
    res.json(data);
  });
});
// GET all features
app.get("/admin/whychooseus", (req, res) => {
  const q = "SELECT * FROM why_choose_us";
  db.query(q, (err, data) => {
    if (err) return res.status(500).json(err);
    res.json(data);
  });
});

// UPDATE feature
app.put("/admin/whychooseus/update/:id", (req, res) => {
const { iconName , title, description,orderNumber } = req.body;
  const id = req.params.id;
  const q = "UPDATE why_choose_us SET icon=?, title=?,description=?, order_number=? WHERE reason_id=?";
  db.query(q, [iconName, title,description,orderNumber, id], (err,data) => {
    if (err) return res.status(500).json(err);
    res.json(data);
  });
});
// ADD feature
app.post("/admin/whychooseus/add", (req, res) => {
const { iconName , title, description,orderNumber } = req.body;
const q =
"INSERT INTO why_choose_us(`icon`,`title`,`description`,`order_number`) VALUES (?, ?, ? , ?)";
db.query(q, [iconName, title,description, orderNumber], (err, data) => {
if (err) return res.send(err);
return res.json(data);
});
});
// DELETE feature
app.delete("/admin/whychooseus/delete/:id", (req, res) => {
 const id = req.params.id;
  const q = "DELETE FROM why_choose_us WHERE reason_id=?";
  db.query(q, [id], (err,data) => {
    if (err) return res.status(500).json(err);
    res.json(data);
  });
});
// multer storage
const storage = multer.diskStorage({
destination: (req, file, cb) => {
// folder where images will be stored
cb(null, "images/");
},
filename: (req, file, cb) => {
  cb(
null,
file.originalname + "_" + Date.now() +
path.extname(file.originalname)
);
},
});
const upload = multer({ storage: storage });
// ADD testinomials by image
app.post("/admin/testinomials/add",upload.single("image"), (req, res) => {
const { name , text, rating } = req.body;
const q =
"INSERT INTO testimonials(`name`,`text`,`rating`,`image`) VALUES (?, ?, ? , ?)";
// Access file info from req.file
const imageFileName = req.file ? req.file.filename : null;
db.query(q, [name, text,rating, imageFileName], (err, data) => {
if (err) return res.send(err);
return res.status(200).json("Testinomial added successfully");
});
});
// GET all testinomials
app.get("/admin/testinomials", (req, res) => {
  const q = "SELECT * FROM testimonials";
  db.query(q, (err, data) => {
    if (err) return res.status(500).json(err);
    res.json(data);
  });
});
// DELETE testinomials
app.delete("/admin/testinomials/delete/:id", (req, res) => {
 const id = req.params.id;
  const q = "DELETE FROM testimonials WHERE testimonial_id=?";
  db.query(q, [id], (err,data) => {
    if (err) return res.status(500).json(err);
    res.json(data);
  });
});
// UPDATE testinomials by image
app.put("/admin/testinomials/update/:id",upload.single("image"), (req, res) => {
const { name , text, rating } = req.body;
 const id = req.params.id;
 const q = "UPDATE testimonials SET name=?, text=?,rating=?, image=? WHERE testimonial_id=?";
// Access file info from req.file
const imageFileName = req.file ? req.file.filename : null;
db.query(q, [name, text,rating, imageFileName,id], (err, data) => {
if (err) return res.send(err);
return res.status(200).json("Testinomial updated successfully");
});
});
// GET all categories
app.get("/admin/categories", (req, res) => {
  const q = "SELECT * FROM categories";
  db.query(q, (err, data) => {
    if (err) return res.status(500).json(err);
    res.json(data);
  });
});

// UPDATE category
app.put("/admin/categories/update/:id", (req, res) => {
  const { categoryID , name } = req.body;
  const { id } = req.params;
  const q = "UPDATE categories SET category_id=?, name=? WHERE category_id=?";
  db.query(q, [categoryID, name, id], (err,data) => {
    if (err) return res.status(500).json(err);
    res.json(data);
  });
});
// ADD category
app.post("/admin/categories/add", (req, res) => {
const { id , name} = req.body;
const q =
"INSERT INTO categories(`category_id`,`name`) VALUES (?, ?)";
db.query(q, [id, name], (err, data) => {
if (err) return res.send(err);
return res.json(data);
});
});
// DELETE category
app.delete("/admin/categories/delete/:id", (req, res) => {
 const id = req.params.id;
  const q = "DELETE FROM categories WHERE category_id=?";
  db.query(q, [id], (err,data) => {
    if (err) return res.status(500).json(err);
    res.json(data);
  });
});
// FETCH ABOUT PAGE
app.get("/admin/about", (req, res) => {
  const q = "SELECT * FROM about_page LIMIT 1";
  db.query(q, (err, data) => {
    if (err) return res.status(500).json(err);
    res.json(data[0]);
  });
});
// ✅ UPDATE ABOUT PAGE
app.put("/admin/about/update/:id", upload.single("image"), (req, res) => {
  const id = req.params.id;

  const {title,main_description,secondary_description,philosophy_title,philosophy_quote,button_text,button_link,
  } = req.body;
  const image = req.file ? req.file.filename : req.body.image;

  const q = `UPDATE about_page SET
      title = ?,
      main_description = ?,
      secondary_description = ?,
      philosophy_title = ?,
      philosophy_quote = ?,
      button_text = ?,
      button_link = ?,
      image = ?
    WHERE id = ?
  `;

  db.query(q,[title,main_description, secondary_description, philosophy_title, philosophy_quote, button_text,
      button_link,
      image,
      id,
    ],
    (err) => {
      if (err) return res.status(500).json(err);
      res.json("About page updated successfully");
    }
  );
});
// GET ALL RECIPES (with category name)
app.get("/admin/recipes", (req, res) => {
  const q = `
    SELECT 
      r.recipe_id,
      r.name,
      r.description,
      r.calories,
      r.protein,
      r.carbs,
      r.fats,
      r.image,
      r.category_id,
      c.name AS category_name
    FROM recipes r
    INNER JOIN categories c ON r.category_id = c.category_id
  `;
  db.query(q, (err, data) => {
    if (err) return res.status(500).json(err);
    res.json(data);
  });
});


// ADD NEW RECIPE
app.post("/admin/recipes/add", upload.single("image"), (req, res) => {
  const q = `
    INSERT INTO recipes
    (name, description, calories, protein, carbs, fats, image, category_id)
    VALUES (?,?,?,?,?,?,?,?)
  `;

  const values = [
    req.body.name,
    req.body.description,
    req.body.calories,
    req.body.protein,
    req.body.carbs,
    req.body.fats,
    req.file?.filename,
    req.body.category_id,
  ];

  db.query(q, values, (err) => {
    if (err) return res.status(500).json(err);
    res.json("Recipe added successfully");
  });
});


// UPDATE RECIPE
app.put("/admin/recipes/update/:id", upload.single("image"), (req, res) => {
  const q = `
    UPDATE recipes SET
      name=?,
      description=?,
      calories=?,
      protein=?,
      carbs=?,
      fats=?,
      image=?,
      category_id=?
    WHERE recipe_id=?
  `;

  const values = [
    req.body.name,
    req.body.description,
    req.body.calories,
    req.body.protein,
    req.body.carbs,
    req.body.fats,
    req.file ? req.file.filename : req.body.image, // if no new image, keep old
    req.body.category_id,
    req.params.id,
  ];

  db.query(q, values, (err) => {
    if (err) return res.status(500).json(err);
    res.json("Recipe updated successfully");
  });
});


// DELETE RECIPE
app.delete("/admin/recipes/delete/:id", (req, res) => {
  const q = "DELETE FROM recipes WHERE recipe_id=?";
  db.query(q, [req.params.id], (err) => {
    if (err) return res.status(500).json(err);
    res.json("Recipe deleted successfully");
  });
});

// GET contact info
app.get("/admin/contact", (req, res) => {
  const q = "SELECT * FROM contact";
  db.query(q, (err, data) => {
    if (err) return res.status(500).json(err);
    res.json(data[0]);
  });
});

// UPDATE contact info
app.put("/admin/contact/update/:id", upload.single("map_image"), (req, res) => {
  const q = `
    UPDATE contact SET phone=?, email=?,location=?,map_image=?WHERE contact_id=?`;
  const mapImage = req.file ? req.file.filename : req.body.map_image;
  const values = [req.body.phone, req.body.email, req.body.location, mapImage, req.params.id];

  db.query(q, values, (err) => {
    if (err) return res.status(500).json(err);
    res.json("Contact info updated successfully");
  });
});
// --- Contact Messages APIs ---

// GET all messages
app.get("/admin/messages", (req, res) => {
  const q = "SELECT * FROM contact_messages ORDER BY created_at DESC";
  db.query(q, (err, data) => {
    if (err) return res.status(500).json(err);
    res.json(data);
  });
});
// POST contact message
app.post("/contact/messages", (req, res) => {
  const { name, email, message } = req.body;

  const q =
    "INSERT INTO contact_messages (name, email, message) VALUES (?, ?, ?)";

  db.query(q, [name, email, message], (err) => {
    if (err) return res.status(500).json(err);
    res.json({ message: "Message saved" });
  });
});
// Mark message as read
app.put("/admin/messages/read/:id", (req, res) => {
  const q = "UPDATE contact_messages SET is_read=TRUE WHERE message_id=?";
  db.query(q, [req.params.id], (err) => {
    if (err) return res.status(500).json(err);
    res.json("Message marked as read");
  });
});

// Delete message
app.delete("/admin/messages/delete/:id", (req, res) => {
  const q = "DELETE FROM contact_messages WHERE message_id=?";
  db.query(q, [req.params.id], (err) => {
    if (err) return res.status(500).json(err);
    res.json("Message deleted");
  });
});
// DASHBOARD ✅
app.get("/dashboard", (req, res) => {
  const statsQuery = `
    SELECT
      (SELECT COUNT(*) FROM users) AS users,
      (SELECT COUNT(*) FROM recipes) AS recipes,
      (SELECT COUNT(*) FROM categories) AS categories,
      (SELECT COUNT(*) FROM contact_messages) AS messages
  `;

  db.query(statsQuery, (err, statsResult) => {
    if (err) return res.status(500).json(err);

    const pieQuery = `
      SELECT 
      c.name AS category,
      ROUND(AVG(r.calories)) AS avg_calories
    FROM recipes r
    INNER JOIN categories c ON r.category_id = c.category_id
    GROUP BY c.name
    `;

    db.query(pieQuery, (err, pieResult) => {
      if (err) return res.status(500).json(err);

      const barQuery = `
        SELECT c.name AS name, COUNT(r.category_id) AS total
        FROM categories c
        LEFT JOIN recipes r ON c.category_id = r.category_id
        GROUP BY c.name
      `;

      db.query(barQuery, (err, barResult) => {
        if (err) return res.status(500).json(err);

        res.json({
          cards: statsResult[0],
          pieChart: pieResult,
          barChart: barResult
        });
      });
    });
  });
});
// Serve React build
app.use(express.static(path.join(__dirname, "build")));
app.get("/*", (req, res) => {
  res.sendFile(path.join(__dirname, "build", "index.html"));
});
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
