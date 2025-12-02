<?php
// Current server datetime
$serverNow = new DateTime("now",new DateTimeZone("Asia/Manila"));

// UAE datetime (Asia/Dubai)
$uaeNow = new DateTime("now", new DateTimeZone("Asia/Dubai"));
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Greeting Page</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 flex items-center justify-center h-screen">
    <div class="bg-white p-8 rounded-lg shadow-lg text-center">
        <h1 class="text-3xl font-bold text-blue-600 mb-4">THIS IS MODIFIED THRU GIT 👋</h1>

        <p class="text-gray-700 text-lg mb-2">
            <strong>Server Date & Time:</strong><br>
            <?php echo $serverNow->format('Y-m-d H:i:s'); ?>
        </p>

        <p class="text-gray-700 text-lg">
            <strong>UAE Date & Time (Asia/Dubai):</strong><br>
            <?php echo $uaeNow->format('Y-m-d H:i:s'); ?>
        </p>
    </div>
</body>
</html>