<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AnimeTracker Dashboard</title>
    <style>
        /* Basic Reset and Font */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        /* Body Styling */
        body {
            background: linear-gradient(135deg, #1c203b 0%, #2b2f54 50%, #1c203b 100%);
            color: #ffffff;
            background-attachment: fixed; /* Keep gradient fixed during scroll */
        }

        /* Navbar Styling */
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 40px;
            background: linear-gradient(90deg, #252a4a 0%, #383f71 50%, #252a4a 100%);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
            position: sticky; /* Make navbar sticky */
            top: 0;
            z-index: 1000; /* Ensure navbar is above other content */
        }

        .logo {
            display: flex;
            align-items: center;
        }

        .logo img {
            width: 40px;
            height: 40px;
            border-radius: 50%; /* Make logo icon round */
        }

        .nav-links {
            display: flex;
            gap: 30px;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            font-weight: 500;
            position: relative;
            padding-bottom: 5px;
            transition: color 0.3s ease;
        }

        .nav-links a:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 0;
            height: 2px;
            background: linear-gradient(90deg, #5d5fef, #8a5fed);
            transition: width 0.3s ease;
        }

        .nav-links a:hover {
            color: #c0c0ff; /* Lighter color on hover */
        }

        .nav-links a:hover:after {
            width: 100%;
        }

        .login-btn {
            background: linear-gradient(90deg, #5d5fef 0%, #8a5fed 100%);
            color: white;
            border: none;
            padding: 8px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            transition: all 0.3s ease;
        }

        .login-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(93, 95, 239, 0.4);
        }

        /* Main Container */
        .container {
            max-width: 1200px;
            margin: 30px auto; /* Add more margin top */
            padding: 0 20px;
            position: relative;
        }

        /* Background Character Image (Subtle) */
        .background-characters {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            opacity: 0.05; /* Make it very subtle */
            z-index: -1;
            background-image: url('https://placehold.co/1920x1080/1c203b/333333?text=Subtle+BG'); /* Placeholder for subtle pattern/image */
            background-size: cover;
            background-repeat: no-repeat;
        }

        /* Dashboard Header: Welcome + Search */
        .dashboard-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            position: relative;
            flex-wrap: wrap; /* Allow wrapping on smaller screens */
            gap: 15px;
        }

        .welcome-user {
            font-size: 24px;
            font-weight: bold;
            background: linear-gradient(90deg, #ffffff, #a0a0ff);
            -webkit-background-clip: text;
            background-clip: text; /* Standard property */
            color: transparent; /* Use transparent color */
            -webkit-text-fill-color: transparent; /* For Safari */
            text-shadow: 0 2px 10px rgba(255, 255, 255, 0.1);
        }

        

         

        /* Dashboard Stats Cards */
        .dashboard-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); /* Responsive grid */
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: linear-gradient(135deg, #252a4a 0%, #323865 100%);
            padding: 25px; /* Increase padding */
            border-radius: 10px;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            position: relative;
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
        }

        /* Subtle radial gradient effect inside card */
        .stat-card::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(93, 95, 239, 0.08) 0%, rgba(93, 95, 239, 0) 70%);
            z-index: 0;
            transition: opacity 0.3s ease;
            opacity: 0; /* Hidden by default */
        }
         .stat-card:hover::before {
            opacity: 1; /* Show on hover */
         }

        .stat-number {
            font-size: 32px;
            font-weight: bold;
            margin-bottom: 5px;
            background: linear-gradient(90deg, #5d5fef, #8a5fed);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            -webkit-text-fill-color: transparent;
            position: relative;
            z-index: 1;
        }

        .stat-label {
            font-size: 14px;
            color: #a0a0ff; /* Brighter label color */
            position: relative;
            z-index: 1;
        }

        /* Featured Banner */
        .featured-banner {
            height: 200px; /* Increased height */
            margin-bottom: 30px;
            border-radius: 15px;
            overflow: hidden;
            position: relative;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.3);
        }

        .featured-banner img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }

        .featured-banner:hover img {
            transform: scale(1.05); /* Slightly larger scale effect */
        }

        .featured-overlay {
            position: absolute;
            bottom: 0; /* Position overlay at the bottom */
            left: 0;
            width: 100%;
            height: 60%; /* Cover bottom part */
            background: linear-gradient(0deg, rgba(28, 32, 59, 0.9) 0%, rgba(28, 32, 59, 0) 100%); /* Gradient from bottom */
            display: flex;
            align-items: flex-end; /* Align text to bottom */
            padding: 25px; /* Increased padding */
            transition: background 0.3s ease;
        }
         .featured-banner:hover .featured-overlay {
             background: linear-gradient(0deg, rgba(28, 32, 59, 0.95) 0%, rgba(28, 32, 59, 0.1) 100%); /* Darker on hover */
         }

        .featured-title {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 5px;
            text-shadow: 0 2px 5px rgba(0,0,0,0.5);
        }

        .featured-info {
            font-size: 14px;
            opacity: 0.9; /* Slightly more opaque */
            text-shadow: 0 1px 3px rgba(0,0,0,0.5);
        }

        /* Main Dashboard Layout (2 columns) */
        .dashboard-content {
            display: grid;
            grid-template-columns: 2fr 1fr; /* 2/3 for main, 1/3 for sidebar */
            gap: 30px;
            margin-top: 30px; /* Add margin */
        }

        /* Anime List Section (Left Column - Replaced with Full List Table) */
        .my-anime-list-container { /* Renamed container */
            background: linear-gradient(135deg, rgba(37, 42, 74, 0.8) 0%, rgba(50, 56, 101, 0.8) 100%); /* Slightly transparent */
            backdrop-filter: blur(5px); /* Frosted glass effect */
            border-radius: 10px;
            padding: 0; /* Remove padding for table */
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            position: relative;
            overflow: hidden; /* Clip table corners */
        }

        /* Optional subtle background image inside the list container */
        .my-anime-list-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('https://placehold.co/800x600/252a4a/444444?text=BG+Pattern') no-repeat;
            background-size: cover;
            opacity: 0.03;
            z-index: 0;
        }

        /* Section Title Styling */
        .section-title {
            font-size: 20px; /* Slightly larger */
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: relative;
            z-index: 1;
            border-bottom: 1px solid rgba(93, 95, 239, 0.3); /* Subtle underline */
            padding-bottom: 10px;
        }
        /* Add padding back for titles outside the table container */
        .section-title-padding {
             padding: 25px 25px 0 25px; /* Padding for title above table */
             margin-bottom: 0;
             border-bottom: none;
        }


        .section-title span {
            background: linear-gradient(90deg, #ffffff, #c0c0ff); /* Adjusted gradient */
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            -webkit-text-fill-color: transparent;
            font-weight: bold;
        }

        .view-all {
            color: #8a5fed; /* Use accent color */
            font-size: 14px;
            text-decoration: none;
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .view-all:hover {
            color: #a0a0ff; /* Lighter on hover */
            text-decoration: underline;
        }

        /* Styling for the Anime List Table */
        .my-anime-table {
            width: 100%;
            border-collapse: collapse; /* Remove gaps between cells */
            position: relative;
            z-index: 1;
        }

        .my-anime-table thead {
            background-color: rgba(28, 32, 59, 0.6); /* Darker, semi-transparent header */
        }

        .my-anime-table th {
            padding: 12px 15px;
            text-align: left;
            font-size: 12px;
            font-weight: bold;
            color: #a0a0ff; /* Header text color */
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .my-anime-table tbody tr {
            border-bottom: 1px solid rgba(93, 95, 239, 0.2); /* Separator line */
            transition: background-color 0.3s ease;
        }

        .my-anime-table tbody tr:last-child {
            border-bottom: none; /* Remove border for last row */
        }

        .my-anime-table tbody tr:hover {
            background-color: rgba(93, 95, 239, 0.1); /* Highlight on hover */
        }

        .my-anime-table td {
            padding: 12px 15px;
            vertical-align: middle; /* Align content vertically */
            font-size: 14px;
            color: #e0e0ff; /* Lighter text color */
        }

        .my-anime-table .anime-poster-cell img {
            width: 50px;
            height: 70px;
            object-fit: cover;
            border-radius: 4px;
            display: block; /* Remove extra space */
            box-shadow: 0 2px 5px rgba(0,0,0,0.3);
        }

        .my-anime-table .title-cell .main-title {
            font-weight: 600;
            color: #ffffff;
            display: block; /* Ensure it takes full width */
            margin-bottom: 2px;
        }

        .my-anime-table .title-cell .alt-title {
            font-size: 12px;
            color: #a0a0e0;
            display: block;
        }

        .my-anime-table .score-cell {
            font-weight: bold;
            color: #facc15; /* Yellow for score */
        }
         .my-anime-table .score-cell.no-score {
             color: #a0a0e0; /* Grey if no score */
             font-style: italic;
         }

        /* Status Badges */
        .status-badge {
            padding: 4px 10px;
            border-radius: 12px; /* Pill shape */
            font-size: 11px;
            font-weight: bold;
            text-transform: uppercase;
            display: inline-block;
            white-space: nowrap;
        }

        .status-watching {
            background-color: rgba(59, 130, 246, 0.3); /* Blue */
            color: #93c5fd;
            border: 1px solid rgba(59, 130, 246, 0.5);
        }

        .status-completed {
            background-color: rgba(34, 197, 94, 0.3); /* Green */
            color: #86efac;
             border: 1px solid rgba(34, 197, 94, 0.5);
        }

        .status-plan-to-watch {
            background-color: rgba(168, 85, 247, 0.3); /* Purple */
            color: #d8b4fe;
             border: 1px solid rgba(168, 85, 247, 0.5);
        }

        .status-on-hold {
            background-color: rgba(249, 115, 22, 0.3); /* Orange */
            color: #fdba74;
             border: 1px solid rgba(249, 115, 22, 0.5);
        }

        .status-dropped {
            background-color: rgba(239, 68, 68, 0.3); /* Red */
            color: #fca5a5;
             border: 1px solid rgba(239, 68, 68, 0.5);
        }

        /* Action Buttons */
        .action-buttons button {
            background: none;
            border: none;
            cursor: pointer;
            padding: 5px;
            margin-left: 8px;
            transition: transform 0.2s ease, opacity 0.2s ease;
            opacity: 0.7;
        }
         .action-buttons button:hover {
             opacity: 1;
             transform: scale(1.1);
         }

        .action-buttons button svg {
            width: 18px;
            height: 18px;
            vertical-align: middle;
        }

        .edit-btn svg {
             stroke: #8a5fed; /* Purple */
        }
         .edit-btn:hover svg {
             stroke: #a0a0ff;
         }

        .delete-btn svg {
            stroke: #ef4444; /* Red */
        }
         .delete-btn:hover svg {
             stroke: #fca5a5;
         }

        /* Table Pagination (Example) */
        .table-pagination {
            padding: 15px 25px;
            background-color: rgba(28, 32, 59, 0.6);
            border-top: 1px solid rgba(93, 95, 239, 0.2);
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 13px;
            color: #a0a0e0;
            position: relative;
            z-index: 1;
        }
         .pagination-buttons button {
             background: linear-gradient(135deg, #373d5c 0%, #4a5180 100%);
             border: 1px solid rgba(93, 95, 239, 0.3);
             color: #e0e0ff;
             padding: 6px 12px;
             border-radius: 5px;
             cursor: pointer;
             margin-left: 5px;
             transition: background 0.3s ease, border-color 0.3s ease;
             font-size: 12px;
         }
          .pagination-buttons button:hover {
              background: linear-gradient(135deg, #4a5180 0%, #5d669d 100%);
              border-color: rgba(93, 95, 239, 0.6);
          }
           .pagination-buttons button:disabled {
               opacity: 0.5;
               cursor: not-allowed;
           }


        /* Sidebar Content (Right Column) */
        .side-content {
            display: flex;
            flex-direction: column;
            gap: 30px;
        }

        /* Shared Styles for Sidebar Cards */
        .recommendations, .seasonal-anime { /* Removed .friends-activity */
            background: linear-gradient(135deg, rgba(37, 42, 74, 0.8) 0%, rgba(50, 56, 101, 0.8) 100%);
            backdrop-filter: blur(5px);
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            position: relative;
            overflow: hidden;
        }

        .recommendations::before, .seasonal-anime::before { /* Removed .friends-activity */
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('https://placehold.co/400x400/252a4a/444444?text=BG') no-repeat;
            background-size: cover;
            opacity: 0.03;
            z-index: 0;
        }

        /* Recommendations Section */
        .recommendation-items, .seasonal-items { /* Removed .friend-items */
            display: grid;
            gap: 15px;
            position: relative;
            z-index: 1;
        }

        .recommendation-item {
            display: flex;
            gap: 15px;
            background: linear-gradient(135deg, rgba(28, 32, 59, 0.7) 0%, rgba(39, 43, 77, 0.7) 100%);
            backdrop-filter: blur(3px);
            border-radius: 10px;
            padding: 15px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.2);
             border: 1px solid rgba(93, 95, 239, 0.1);
        }

        .recommendation-item:hover {
            transform: translateY(-3px) scale(1.01);
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.3);
             border-color: rgba(93, 95, 239, 0.4);
        }

        .recommendation-poster {
            width: 60px;
            height: 85px; /* Adjusted height */
            border-radius: 5px;
            object-fit: cover;
            transition: transform 0.3s ease;
            flex-shrink: 0;
        }

        .recommendation-item:hover .recommendation-poster {
            transform: scale(1.05);
        }

        .recommendation-details {
            flex: 1;
        }

        .recommendation-title {
            font-weight: bold;
            margin-bottom: 5px;
            font-size: 14px;
             line-height: 1.3;
        }

        .recommendation-info {
            color: #a0a0e0; /* Lighter info */
            font-size: 12px;
        }


        /* Seasonal Anime Section */
        .seasonal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px; /* Reduced margin */
            position: relative;
            z-index: 1;
             flex-wrap: wrap; /* Allow wrapping */
             gap: 10px;
        }

        .season-tabs {
            display: flex;
            gap: 10px;
             flex-wrap: wrap;
        }

        .season-tab {
            padding: 5px 12px; /* Adjust padding */
            background: rgba(93, 95, 239, 0.2);
            border-radius: 5px;
            font-size: 12px;
            cursor: pointer;
            transition: background 0.3s ease, color 0.3s ease;
            color: #c0c0ff;
             border: 1px solid rgba(93, 95, 239, 0.3);
        }

        .season-tab.active {
            background: linear-gradient(90deg, #5d5fef 0%, #8a5fed 100%);
            color: white;
            font-weight: bold;
             border-color: transparent;
        }

        .season-tab:hover:not(.active) {
            background: rgba(93, 95, 239, 0.4);
            color: white;
        }

        .seasonal-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(120px, 1fr)); /* Responsive grid */
            gap: 15px; /* Increased gap */
            position: relative;
            z-index: 1;
        }

        .seasonal-card {
            position: relative;
            overflow: hidden;
            border-radius: 8px;
            height: 100px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
             box-shadow: 0 3px 10px rgba(0, 0, 0, 0.2);
        }

        .seasonal-card:hover {
            transform: translateY(-3px);
             box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
        }

        .seasonal-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
             transition: transform 0.3s ease;
        }
         .seasonal-card:hover .seasonal-img {
             transform: scale(1.05);
         }

        .seasonal-overlay {
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            padding: 8px 10px; /* Adjust padding */
            background: linear-gradient(0deg, rgba(0, 0, 0, 0.85) 0%, rgba(0, 0, 0, 0) 100%);
            font-size: 12px;
            font-weight: bold;
            text-shadow: 0 1px 3px rgba(0,0,0,0.7);
             line-height: 1.3;
        }

        /* Genre/Category Banners */
        .banner-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr)); /* Responsive */
            gap: 20px; /* Increased gap */
            margin-bottom: 30px;
        }

        .anime-banner {
            height: 100px; /* Reduced height */
            border-radius: 10px;
            overflow: hidden;
            position: relative;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .anime-banner:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.4);
        }

        .anime-banner img {
            width: 100%;
            height: 100%;
            object-fit: cover;
             transition: transform 0.4s ease;
        }
         .anime-banner:hover img {
             transform: scale(1.1);
         }

        .anime-banner-overlay {
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            padding: 12px; /* Increased padding */
            background: linear-gradient(0deg, rgba(0, 0, 0, 0.8) 0%, rgba(0, 0, 0, 0) 100%);
            font-size: 14px; /* Larger text */
            font-weight: bold;
            text-align: center; /* Center text */
            text-shadow: 0 1px 3px rgba(0,0,0,0.7);
        }

        /* Floating Decorative Images */
        .floating-images {
            position: fixed; /* Use fixed to keep them relative to viewport */
            width: 300px; /* Adjust size */
            height: 300px;
            opacity: 0.1; /* Make them very subtle */
            z-index: -1; /* Behind content */
            pointer-events: none; /* Ignore mouse events */
        }

        .floating-1 {
            top: 15%;
            left: 5%;
            transform: rotate(-15deg);
        }

        .floating-2 {
            bottom: 10%;
            right: 5%;
            transform: rotate(10deg);
        }
        .floating-3 {
            top: 15%;
            right: 5%;
            transform: rotate(-15deg);
        }

        .floating-4 {
            bottom: 10%;
            left: 5%;
            transform: rotate(10deg);
        }

        /* Trending Anime Section (Horizontal Scroll) */
        .trending-anime {
            margin-top: 30px;
            margin-bottom: 30px;
            position: relative;
        }

        .trending-scroll {
            display: flex;
            gap: 20px; /* Increased gap */
            overflow-x: auto;
            padding: 5px 5px 20px 5px; /* Add padding bottom for scrollbar */
            position: relative;
            z-index: 1;
            scrollbar-width: thin; /* Firefox */
            scrollbar-color: #5d5fef #1c203b; /* Firefox */
        }

        /* Webkit scrollbar styling */
        .trending-scroll::-webkit-scrollbar {
            height: 8px;
        }
        .trending-scroll::-webkit-scrollbar-track {
            background: rgba(28, 32, 59, 0.5);
            border-radius: 4px;
        }
        .trending-scroll::-webkit-scrollbar-thumb {
            background: linear-gradient(90deg, #5d5fef 0%, #8a5fed 100%);
            border-radius: 4px;
        }
        .trending-scroll::-webkit-scrollbar-thumb:hover {
            background: linear-gradient(90deg, #4a4cd8 0%, #7245d8 100%);
        }

        .trending-card {
            min-width: 160px; /* Increased width */
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            position: relative;
            background: #252a4a; /* Add background for consistency */
        }

        .trending-card:hover {
            transform: translateY(-5px) scale(1.03);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.4);
        }

        .trending-poster {
            width: 100%; /* Make poster fill card width */
            height: 220px; /* Adjusted height */
            object-fit: cover;
            display: block; /* Remove extra space below image */
        }

        .trending-overlay {
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            background: linear-gradient(0deg, rgba(0, 0, 0, 0.9) 0%, rgba(0, 0, 0, 0) 100%);
            padding: 12px; /* Increased padding */
        }

        .trending-title {
            font-size: 14px;
            font-weight: bold;
            margin-bottom: 5px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
             text-shadow: 0 1px 2px rgba(0,0,0,0.7);
        }

        .trending-info {
            font-size: 12px;
            color: #a0a0e0;
             text-shadow: 0 1px 2px rgba(0,0,0,0.7);
        }

        .trending-rank {
            position: absolute;
            top: 10px;
            left: 10px;
            background: linear-gradient(135deg, #5d5fef 0%, #8a5fed 100%);
            color: white;
            width: 30px;
            height: 30px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 14px;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.3);
            border: 2px solid rgba(255,255,255,0.5); /* Add border */
        }

        /* Recently Completed Section */
        .recently-completed {
            margin-top: 30px;
            margin-bottom: 30px;
            background: linear-gradient(135deg, rgba(37, 42, 74, 0.8) 0%, rgba(50, 56, 101, 0.8) 100%);
            backdrop-filter: blur(5px);
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            position: relative;
            overflow: hidden;
        }

        .recently-completed::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('https://placehold.co/800x600/252a4a/444444?text=BG') no-repeat;
            background-size: cover;
            opacity: 0.03;
            z-index: 0;
        }

        .recently-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr)); /* Responsive grid */
            gap: 20px; /* Increased gap */
            position: relative;
            z-index: 1;
        }

        .recently-card {
            background: linear-gradient(135deg, rgba(28, 32, 59, 0.7) 0%, rgba(39, 43, 77, 0.7) 100%);
            backdrop-filter: blur(3px);
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
             border: 1px solid rgba(93, 95, 239, 0.1);
        }

        .recently-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
             border-color: rgba(93, 95, 239, 0.4);
        }

        .recently-poster {
            width: 100%;
            height: 180px;
            object-fit: cover;
            display: block;
        }

        .recently-details {
            padding: 15px; /* Increased padding */
        }

        .recently-title {
            font-size: 14px;
            font-weight: bold;
            margin-bottom: 5px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .recently-info {
            font-size: 12px;
            color: #a0a0e0;
            margin-bottom: 8px; /* Add margin bottom */
        }

        .recently-score {
            display: inline-block;
            background: linear-gradient(90deg, #5d5fef 0%, #8a5fed 100%);
            color: white;
            padding: 3px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: bold;
        }

        /* Footer Styling */
        .footer {
            background: linear-gradient(90deg, #252a4a 0%, #383f71 50%, #252a4a 100%);
            padding: 30px 0;
            margin-top: 50px; /* Increased margin */
            text-align: center;
            box-shadow: 0 -4px 15px rgba(0, 0, 0, 0.3);
        }

        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .footer-links {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 25px; /* Increased gap */
            margin-bottom: 20px;
        }

        .footer-links a {
            color: #a0a0ff; /* Brighter link color */
            text-decoration: none;
            font-size: 14px;
            transition: color 0.3s ease;
        }

        .footer-links a:hover {
            color: #ffffff;
        }

        .footer-copyright {
            color: #a0a0a0;
            font-size: 14px;
        }

         /* Responsive Adjustments */
         @media (max-width: 992px) {
             .dashboard-content {
                 grid-template-columns: 1fr; /* Stack columns */
             }
             .banner-grid {
                 grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
             }
             .recently-grid {
                 grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
             }
             /* Make table scrollable on smaller screens */
             .my-anime-list-container {
                 overflow-x: auto; /* Enable horizontal scroll for table container */
             }
             .my-anime-table {
                 min-width: 700px; /* Ensure table has minimum width */
             }
         }

         @media (max-width: 768px) {
             .navbar {
                 padding: 15px 20px; /* Reduce padding */
                 flex-direction: column; /* Stack navbar items */
                 gap: 15px;
             }
             .nav-links {
                 gap: 20px;
                 justify-content: center;
                 width: 100%;
             }
              .dashboard-header {
                 flex-direction: column;
                 align-items: flex-start;
             }
             
             .dashboard-stats {
                 grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
             }
              .seasonal-grid {
                 grid-template-columns: repeat(auto-fit, minmax(100px, 1fr));
             }
             .footer-links {
                 gap: 15px;
             }
         }

          @media (max-width: 480px) {
              .welcome-user {
                 font-size: 20px;
             }
             .stat-number {
                 font-size: 28px;
             }
             .featured-title {
                 font-size: 20px;
             }
             .section-title {
                 font-size: 18px;
             }
             .nav-links a {
                 font-size: 14px;
             }
             .login-btn {
                 width: 100%; /* Full width button */
                 text-align: center;
             }
             .my-anime-table th, .my-anime-table td {
                 padding: 8px 10px; /* Reduce padding on small screens */
                 font-size: 13px;
             }
             .my-anime-table .anime-poster-cell img {
                 width: 40px;
                 height: 56px;
             }
              .status-badge {
                 padding: 3px 8px;
                 font-size: 10px;
             }
              .action-buttons button svg {
                 width: 16px;
                 height: 16px;
             }
              .table-pagination {
                 flex-direction: column;
                 gap: 10px;
                 padding: 10px 15px;
             }
          }

    </style>
</head>
<body>
    <div class="background-characters"></div>
    <img src="${pageContext.request.contextPath}/resources/system/anime_girl_1.jpg" alt="Floating anime character 1" class="floating-images floating-1" onerror="this.style.display='none'">
    <img src="${pageContext.request.contextPath}/resources/system/anime_girl_2.jpg" alt="Floating anime character 2" class="floating-images floating-2" onerror="this.style.display='none'">
    <img src="${pageContext.request.contextPath}/resources/system/anime_girl_1.jpg" alt="Floating anime character 3" class="floating-images floating-3" onerror="this.style.display='none'">
    <img src="${pageContext.request.contextPath}/resources/system/anime_girl_2.jpg" alt="Floating anime character 4" class="floating-images floating-4" onerror="this.style.display='none'">

    <nav class="navbar">
        <div class="logo">
            <img src="https://placehold.co/40x40/5d5fef/ffffff?text=AT" alt="AnimeTracker Logo" onerror="this.src='https://placehold.co/40x40/cccccc/ffffff?text=Logo'">
        </div>
        <div class="nav-links">
            <a href="#">Home</a>
            <a href="#">Anime</a>
            <a href="#">Manga</a>
            <a href="#">Community</a>
            <a href="#">News</a>
        </div>
        <button class="login-btn">MY PROFILE</button>
    </nav>

    <div class="container">
        <div class="dashboard-header">
            <div class="welcome-user">Welcome back, Anime_Fan42!</div>
            
        </div>

        <div class="featured-banner">
            <img src="https://placehold.co/1200x300/323865/ffffff?text=Featured+Anime+Banner+(e.g.,+Demon+Slayer)" alt="Featured anime: Demon Slayer" onerror="this.src='https://placehold.co/1200x300/cccccc/ffffff?text=Error'">
            <div class="featured-overlay">
                <div>
                    <div class="featured-title">Demon Slayer: Entertainment District Arc</div>
                    <div class="featured-info">New Episode Every Sunday • ⭐ 8.9/10 Rating</div>
                </div>
            </div>
        </div>

        <div class="dashboard-stats">
            <div class="stat-card">
                <div class="stat-number">42</div>
                <div class="stat-label">Watching</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">189</div>
                <div class="stat-label">Completed</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">67</div>
                <div class="stat-label">Plan to Watch</div>
            </div>
             <div class="stat-card">
                <div class="stat-number">15</div>
                <div class="stat-label">Dropped / On Hold</div>
            </div>
        </div>

        <div class="section-title" style="border: none; padding-bottom: 0; margin-bottom: 15px;">
             <span>Explore Genres</span>
         </div>
        <div class="banner-grid">
            <a href="#" class="anime-banner">
                <img src="https://placehold.co/300x150/ef4444/ffffff?text=Action+Genre" alt="Action Genre Banner" onerror="this.src='https://placehold.co/300x150/cccccc/ffffff?text=Err'">
                <div class="anime-banner-overlay">Action</div>
            </a>
            <a href="#" class="anime-banner">
                <img src="https://placehold.co/300x150/a855f7/ffffff?text=Fantasy+Genre" alt="Fantasy Genre Banner" onerror="this.src='https://placehold.co/300x150/cccccc/ffffff?text=Err'">
                <div class="anime-banner-overlay">Fantasy</div>
            </a>
            <a href="#" class="anime-banner">
                <img src="https://placehold.co/300x150/ec4899/ffffff?text=Romance+Genre" alt="Romance Genre Banner" onerror="this.src='https://placehold.co/300x150/cccccc/ffffff?text=Err'">
                <div class="anime-banner-overlay">Romance</div>
            </a>
            <a href="#" class="anime-banner">
                <img src="https://placehold.co/300x150/06b6d4/ffffff?text=Sci-Fi+Genre" alt="Sci-Fi Genre Banner" onerror="this.src='https://placehold.co/300x150/cccccc/ffffff?text=Err'">
                <div class="anime-banner-overlay">Sci-Fi</div>
            </a>
        </div>

        <div class="trending-anime">
             <div class="section-title">
                 <span>Trending Now</span>
                 <a href="#" class="view-all">View More</a>
             </div>
             <div class="trending-scroll">
                 <div class="trending-card">
                     <div class="trending-rank">1</div>
                     <img src="https://placehold.co/160x220/db2777/ffffff?text=Trending+1" alt="Trending Anime 1 Poster" class="trending-poster" onerror="this.src='https://placehold.co/160x220/cccccc/ffffff?text=Err'">
                     <div class="trending-overlay">
                         <div class="trending-title">Jujutsu Kaisen S2</div>
                         <div class="trending-info">Action, Fantasy</div>
                     </div>
                 </div>
                 <div class="trending-card">
                     <div class="trending-rank">2</div>
                     <img src="https://placehold.co/160x220/16a34a/ffffff?text=Trending+2" alt="Trending Anime 2 Poster" class="trending-poster" onerror="this.src='https://placehold.co/160x220/cccccc/ffffff?text=Err'">
                     <div class="trending-overlay">
                         <div class="trending-title">Frieren: Beyond Journey's End</div>
                         <div class="trending-info">Adventure, Fantasy</div>
                     </div>
                 </div>
                 <div class="trending-card">
                     <div class="trending-rank">3</div>
                     <img src="https://placehold.co/160x220/f97316/ffffff?text=Trending+3" alt="Trending Anime 3 Poster" class="trending-poster" onerror="this.src='https://placehold.co/160x220/cccccc/ffffff?text=Err'">
                     <div class="trending-overlay">
                         <div class="trending-title">One Piece</div>
                         <div class="trending-info">Action, Adventure</div>
                     </div>
                 </div>
                 </div>
        </div>

        <div class="dashboard-content">
            <div class="my-anime-list-container">
                 <div class="section-title section-title-padding">
                     <span>My Anime List</span>
                     </div>
                 <div style="overflow-x: auto;"> <table class="my-anime-table">
                         <thead>
                             <tr>
                                 <th>Image</th>
                                 <th>Title</th>
                                 <th>Score</th>
                                 <th>Progress</th>
                                 <th>Status</th>
                                 <th>Actions</th>
                             </tr>
                         </thead>
                         <tbody id="my-anime-list-body">
                             <tr data-anime-id="101">
                                 <td class="anime-poster-cell">
                                     <img src="https://placehold.co/50x70/7c3aed/ffffff?text=AoT" alt="Attack on Titan Poster" onerror="this.src='https://placehold.co/50x70/cccccc/ffffff?text=Err'">
                                 </td>
                                 <td class="title-cell">
                                     <span class="main-title">Attack on Titan: Final Season</span>
                                     <span class="alt-title">Shingeki no Kyojin</span>
                                 </td>
                                 <td class="score-cell">9.2</td>
                                 <td>8 / 12</td>
                                 <td><span class="status-badge status-watching">Watching</span></td>
                                 <td class="action-buttons">
                                     <button class="edit-btn" title="Edit Entry">
                                         <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17 3a2.85 2.83 0 1 1 4 4L7.5 20.5 2 22l1.5-5.5Z"/><path d="m15 5 4 4"/></svg>
                                     </button>
                                     <button class="delete-btn" title="Delete Entry">
                                         <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 6h18"/><path d="M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6"/><path d="M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2"/><line x1="10" x2="10" y1="11" y2="17"/><line x1="14" x2="14" y1="11" y2="17"/></svg>
                                     </button>
                                 </td>
                             </tr>
                             <tr data-anime-id="102">
                                 <td class="anime-poster-cell">
                                     <img src="https://placehold.co/50x70/14b8a6/ffffff?text=FMA" alt="Fullmetal Alchemist Poster" onerror="this.src='https://placehold.co/50x70/cccccc/ffffff?text=Err'">
                                 </td>
                                 <td class="title-cell">
                                     <span class="main-title">Fullmetal Alchemist: Brotherhood</span>
                                     <span class="alt-title">Hagane no Renkinjutsushi</span>
                                 </td>
                                 <td class="score-cell">9.1</td>
                                 <td>64 / 64</td>
                                 <td><span class="status-badge status-completed">Completed</span></td>
                                 <td class="action-buttons">
                                     <button class="edit-btn" title="Edit Entry">
                                          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17 3a2.85 2.83 0 1 1 4 4L7.5 20.5 2 22l1.5-5.5Z"/><path d="m15 5 4 4"/></svg>
                                     </button>
                                     <button class="delete-btn" title="Delete Entry">
                                          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 6h18"/><path d="M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6"/><path d="M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2"/><line x1="10" x2="10" y1="11" y2="17"/><line x1="14" x2="14" y1="11" y2="17"/></svg>
                                     </button>
                                 </td>
                             </tr>
                             <tr data-anime-id="103">
                                 <td class="anime-poster-cell">
                                     <img src="https://placehold.co/50x70/0ea5e9/ffffff?text=VS" alt="Vinland Saga Poster" onerror="this.src='https://placehold.co/50x70/cccccc/ffffff?text=Err'">
                                 </td>
                                 <td class="title-cell">
                                     <span class="main-title">Vinland Saga Season 2</span>
                                     <span class="alt-title">Vinrando Saga</span>
                                 </td>
                                 <td class="score-cell no-score">-</td>
                                 <td>0 / 24</td>
                                 <td><span class="status-badge status-plan-to-watch">Plan to Watch</span></td>
                                 <td class="action-buttons">
                                      <button class="edit-btn" title="Edit Entry">
                                          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17 3a2.85 2.83 0 1 1 4 4L7.5 20.5 2 22l1.5-5.5Z"/><path d="m15 5 4 4"/></svg>
                                     </button>
                                     <button class="delete-btn" title="Delete Entry">
                                          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 6h18"/><path d="M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6"/><path d="M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2"/><line x1="10" x2="10" y1="11" y2="17"/><line x1="14" x2="14" y1="11" y2="17"/></svg>
                                     </button>
                                 </td>
                             </tr>
                             <tr data-anime-id="104">
                                 <td class="anime-poster-cell">
                                     <img src="https://placehold.co/50x70/f87171/ffffff?text=Drop" alt="Dropped Anime Poster" onerror="this.src='https://placehold.co/50x70/cccccc/ffffff?text=Err'">
                                 </td>
                                 <td class="title-cell">
                                     <span class="main-title">Some Anime I Dropped</span>
                                     <span class="alt-title">Maybe Later</span>
                                 </td>
                                 <td class="score-cell">4.0</td>
                                 <td>5 / 12</td>
                                 <td><span class="status-badge status-dropped">Dropped</span></td>
                                 <td class="action-buttons">
                                      <button class="edit-btn" title="Edit Entry">
                                          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17 3a2.85 2.83 0 1 1 4 4L7.5 20.5 2 22l1.5-5.5Z"/><path d="m15 5 4 4"/></svg>
                                     </button>
                                     <button class="delete-btn" title="Delete Entry">
                                          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 6h18"/><path d="M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6"/><path d="M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2"/><line x1="10" x2="10" y1="11" y2="17"/><line x1="14" x2="14" y1="11" y2="17"/></svg>
                                     </button>
                                 </td>
                             </tr>
                              <tr data-anime-id="105">
                                 <td class="anime-poster-cell">
                                     <img src="https://placehold.co/50x70/fb923c/ffffff?text=Hold" alt="On Hold Anime Poster" onerror="this.src='https://placehold.co/50x70/cccccc/ffffff?text=Err'">
                                 </td>
                                 <td class="title-cell">
                                     <span class="main-title">Anime On Hold For Now</span>
                                     <span class="alt-title">Will Continue Someday</span>
                                 </td>
                                 <td class="score-cell no-score">-</td>
                                 <td>10 / 24</td>
                                 <td><span class="status-badge status-on-hold">On Hold</span></td>
                                 <td class="action-buttons">
                                      <button class="edit-btn" title="Edit Entry">
                                          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17 3a2.85 2.83 0 1 1 4 4L7.5 20.5 2 22l1.5-5.5Z"/><path d="m15 5 4 4"/></svg>
                                     </button>
                                     <button class="delete-btn" title="Delete Entry">
                                          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 6h18"/><path d="M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6"/><path d="M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2"/><line x1="10" x2="10" y1="11" y2="17"/><line x1="14" x2="14" y1="11" y2="17"/></svg>
                                     </button>
                                 </td>
                             </tr>
                             </tbody>
                     </table>
                 </div>
                 <div class="table-pagination">
                     <div>Showing 1-5 of 313 entries</div>
                     <div class="pagination-buttons">
                         <button disabled>&lt; Prev</button>
                         <button>Next &gt;</button>
                     </div>
                 </div>
            </div>

            <div class="side-content">
                <div class="recommendations">
                    <div class="section-title">
                        <span>Recommendations For You</span>
                    </div>
                    <div class="recommendation-items">
                        <a href="#" class="recommendation-item">
                            <img src="https://placehold.co/60x85/0ea5e9/ffffff?text=Rec+1" alt="Recommendation 1 Poster" class="recommendation-poster" onerror="this.src='https://placehold.co/60x85/cccccc/ffffff?text=Err'">
                            <div class="recommendation-details">
                                <div class="recommendation-title">Vinland Saga Season 2</div>
                                <div class="recommendation-info">Action, Adventure, Drama</div>
                            </div>
                        </a>
                        <a href="#" class="recommendation-item">
                            <img src="https://placehold.co/60x85/facc15/ffffff?text=Rec+2" alt="Recommendation 2 Poster" class="recommendation-poster" onerror="this.src='https://placehold.co/60x85/cccccc/ffffff?text=Err'">
                            <div class="recommendation-details">
                                <div class="recommendation-title">Cyberpunk: Edgerunners</div>
                                <div class="recommendation-info">Action, Sci-Fi</div>
                            </div>
                        </a>
                         <a href="#" class="recommendation-item">
                            <img src="https://placehold.co/60x85/10b981/ffffff?text=Rec+3" alt="Recommendation 3 Poster" class="recommendation-poster" onerror="this.src='https://placehold.co/60x85/cccccc/ffffff?text=Err'">
                            <div class="recommendation-details">
                                <div class="recommendation-title">Summertime Rendering</div>
                                <div class="recommendation-info">Mystery, Supernatural</div>
                            </div>
                        </a>
                    </div>
                </div>

                <div class="seasonal-anime">
                    <div class="seasonal-header">
                         <div class="section-title" style="border: none; padding-bottom: 0; margin-bottom: 0;">
                             <span>Seasonal Charts</span>
                         </div>
                         <div class="season-tabs">
                            <button class="season-tab active">Winter 2025</button>
                            <button class="season-tab">Fall 2024</button>
                        </div>
                    </div>
                    <div class="seasonal-grid">
                        <a href="#" class="seasonal-card">
                            <img src="https://placehold.co/150x100/6366f1/ffffff?text=Winter+1" alt="Seasonal Anime 1" class="seasonal-img" onerror="this.src='https://placehold.co/150x100/cccccc/ffffff?text=Err'">
                            <div class="seasonal-overlay">Solo Leveling</div>
                        </a>
                        <a href="#" class="seasonal-card">
                            <img src="https://placehold.co/150x100/f43f5e/ffffff?text=Winter+2" alt="Seasonal Anime 2" class="seasonal-img" onerror="this.src='https://placehold.co/150x100/cccccc/ffffff?text=Err'">
                            <div class="seasonal-overlay">Mashle S2</div>
                        </a>
                         <a href="#" class="seasonal-card">
                            <img src="https://placehold.co/150x100/84cc16/ffffff?text=Winter+3" alt="Seasonal Anime 3" class="seasonal-img" onerror="this.src='https://placehold.co/150x100/cccccc/ffffff?text=Err'">
                            <div class="seasonal-overlay">Blue Exorcist S3</div>
                        </a>
                         <a href="#" class="seasonal-card">
                            <img src="https://placehold.co/150x100/eab308/ffffff?text=Winter+4" alt="Seasonal Anime 4" class="seasonal-img" onerror="this.src='https://placehold.co/150x100/cccccc/ffffff?text=Err'">
                            <div class="seasonal-overlay">Classroom of the Elite S3</div>
                        </a>
                    </div>
                     <a href="#" class="view-all" style="display: block; text-align: right; margin-top: 15px;">View Full Chart</a>
                </div>
            </div> </div> <div class="recently-completed">
             <div class="section-title">
                 <span>Recently Completed</span>
                 <a href="#" class="view-all">View History</a>
             </div>
             <div class="recently-grid">
                 <a href="#" class="recently-card">
                     <img src="https://placehold.co/200x180/14b8a6/ffffff?text=Completed+1" alt="Recently Completed 1 Poster" class="recently-poster" onerror="this.src='https://placehold.co/200x180/cccccc/ffffff?text=Err'">
                     <div class="recently-details">
                         <div class="recently-title">Fullmetal Alchemist: Brotherhood</div>
                         <div class="recently-info">Finished 2 days ago</div>
                         <span class="recently-score">⭐ 9.1</span>
                     </div>
                 </a>
                 <a href="#" class="recently-card">
                     <img src="https://placehold.co/200x180/f59e0b/ffffff?text=Completed+2" alt="Recently Completed 2 Poster" class="recently-poster" onerror="this.src='https://placehold.co/200x180/cccccc/ffffff?text=Err'">
                     <div class="recently-details">
                         <div class="recently-title">Steins;Gate</div>
                         <div class="recently-info">Finished last week</div>
                          <span class="recently-score">⭐ 9.0</span>
                     </div>
                 </a>
                 </div>
        </div>

    </div> <footer class="footer">
        <div class="footer-content">
            <div class="footer-links">
                <a href="#">About Us</a>
                <a href="#">Contact</a>
                <a href="#">Terms of Service</a>
                <a href="#">Privacy Policy</a>
                <a href="#">FAQ</a>
                <a href="#">API</a>
            </div>
            <div class="footer-copyright">
                &copy; 2025 AnimeTracker. All Rights Reserved. Built with ❤️ for Anime Fans.
            </div>
        </div>
    </footer>

    <script>
        // Get the table body for the main anime list
        const myAnimeListBody = document.getElementById('my-anime-list-body');

        // Add event listener to the table body (event delegation)
        if (myAnimeListBody) {
            myAnimeListBody.addEventListener('click', function(event) {
                // Find the closest button that was clicked
                const button = event.target.closest('button');
                if (!button) return; // Exit if the click wasn't on a button

                // Find the table row associated with the button
                const row = button.closest('tr');
                if (!row) return; // Exit if couldn't find the row

                const animeId = row.dataset.animeId; // Get the anime ID from data attribute
                const animeTitle = row.querySelector('.main-title')?.textContent || 'this anime'; // Get title for messages

                // Handle Edit Button Click
                if (button.classList.contains('edit-btn')) {
                    console.log(`Edit button clicked for anime ID: ${animeId} (${animeTitle})`);
                    // In a real app, you would open an edit modal or form here,
                    // pre-filled with data for this animeId.
                    alert(`Simulating EDIT action for: ${animeTitle} (ID: ${animeId})\n\n(In a real app, this would open an edit form)`);
                }

                // Handle Delete Button Click
                if (button.classList.contains('delete-btn')) {
                    console.log(`Delete button clicked for anime ID: ${animeId} (${animeTitle})`);
                    // Confirm deletion
                    if (confirm(`Are you sure you want to remove "${animeTitle}" (ID: ${animeId}) from your list?`)) {
                        // Remove the row from the table visually
                        row.style.opacity = '0'; // Start fade out effect
                        row.style.transition = 'opacity 0.4s ease-out, transform 0.4s ease-out';
                        row.style.transform = 'translateX(50px)'; // Optional: slide out effect

                        setTimeout(() => {
                            row.remove();
                            // In a real app, you would also send a DELETE request to your Java backend API here
                            // using fetch() or similar, passing the animeId.
                            console.log(`Anime ID: ${animeId} removed from view.`);
                            alert(`"${animeTitle}" (ID: ${animeId}) has been removed from the list.\n\n(In a real app, this action would be saved to the database)`);
                            // Optional: Update stats cards if needed
                        }, 400); // Wait for fade/slide out animation
                    }
                }
            });
        } else {
            console.error("Element with ID 'my-anime-list-body' not found.");
        }
    </script>

</body>
</html>
    