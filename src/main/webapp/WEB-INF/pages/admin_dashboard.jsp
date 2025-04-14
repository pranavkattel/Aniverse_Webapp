<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        /* Basic Reset & Defaults */
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        html {
            font-size: 16px; /* Base font size */
            /* Removed scroll-behavior: smooth; as JS handles view */
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: #1a1a2e; /* Darker base background */
            color: #b0b0d0; /* Adjusted base text color */
            line-height: 1.5;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }

        a {
            color: inherit;
            text-decoration: none;
        }

        button, input, select, textarea {
            font-family: inherit;
            font-size: 100%;
            line-height: inherit;
            color: inherit;
            border: 1px solid transparent; /* Default border */
        }

        button, a.button { /* Apply button styles to links acting as buttons */
            cursor: pointer;
            background-color: transparent;
        }

        table {
            border-collapse: collapse;
            width: 100%; /* Default table width */
        }

        /* Custom scrollbar styles */
        ::-webkit-scrollbar {
            width: 8px;
            height: 8px;
        }
        ::-webkit-scrollbar-track {
            background: #161625; /* Darker track */
            border-radius: 4px;
        }
        ::-webkit-scrollbar-thumb {
            background: linear-gradient(135deg, #4e4eff, #ac4eff); /* Gradient thumb */
            border-radius: 4px;
            border: 2px solid #161625; /* Add border to match track */
        }
        ::-webkit-scrollbar-thumb:hover {
            background: linear-gradient(135deg, #6868ff, #c068ff); /* Lighter gradient on hover */
        }

        /* Layout */
        .dashboard-layout {
            display: flex;
            height: 100vh;
            overflow: hidden;
            background-color: #1a1a2e;
        }

        .sidebar {
            width: 15rem;
            background: linear-gradient(180deg, #1f1f38, #1a1a2e);
            padding: 1rem;
            display: none; /* hidden by default, shown via media query */
            flex-direction: column;
            flex-shrink: 0;
            overflow-y: auto;
            border-right: 1px solid #2a2a4a;
        }

        .main-content-area {
            flex: 1 1 0%;
            display: flex;
            flex-direction: column;
            overflow: hidden;
             background-color: #161625;
             background-image: radial-gradient(rgba(255, 255, 255, 0.03) 1px, transparent 1px);
             background-size: 15px 15px;
        }

        .header {
            background: linear-gradient(90deg, rgba(31, 31, 56, 0.95), rgba(26, 26, 46, 0.9));
            backdrop-filter: blur(5px);
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
            border-bottom: 1px solid #2a2a4a;
            z-index: 10;
            position: sticky;
            top: 0;
        }

        .header-content {
            max-width: 80rem;
            margin-left: auto;
            margin-right: auto;
            padding-left: 1rem;
            padding-right: 1rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            height: 4rem;
        }

        .main-content {
            flex: 1 1 0%;
            overflow-y: auto;
            padding: 1.5rem;
        }

        /* Sidebar Styles */
        .sidebar-header {
            display: flex;
            align-items: center;
            margin-bottom: 2rem;
            padding-left: 0.5rem;
            padding-right: 0.5rem;
            padding-top: 0.25rem;
        }

        .sidebar-logo {
            width: 2rem;
            height: 2rem;
            background: linear-gradient(135deg, #6f6fff, #c06fff);
            border-radius: 0.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 0.625rem;
            box-shadow: 0 3px 5px rgba(0, 0, 0, 0.2);
        }

        .sidebar-logo-text {
            color: #ffffff;
            font-weight: 700;
            font-size: 1.25rem;
            line-height: 1;
        }

        .sidebar-title {
            font-size: 1.125rem;
            font-weight: 600;
            color: #e0e0ff;
        }

        .sidebar-nav {
            flex: 1 1 0%;
        }

        .sidebar-nav ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .sidebar-nav ul li:not(:last-child) {
             margin-bottom: 0.375rem;
        }

        .sidebar-link {
            display: flex;
            align-items: center;
            padding: 0.625rem 0.75rem;
            font-size: 0.875rem;
            font-weight: 500;
            color: #c0c0e0;
            border-radius: 0.375rem;
            transition: background-color 0.15s ease-in-out, color 0.15s ease-in-out, transform 0.1s ease-in-out;
            border: 1px solid transparent;
        }

        .sidebar-link:hover {
            background-color: rgba(79, 70, 229, 0.2);
            color: #ffffff;
            border-color: rgba(79, 70, 229, 0.5);
            transform: translateX(3px);
        }

        .sidebar-link svg {
            width: 1.25rem;
            height: 1.25rem;
            margin-right: 0.75rem;
            color: #9090c0;
            transition: color 0.15s ease-in-out;
        }
         .sidebar-link:hover svg {
             color: #ffffff;
         }

        /* Sidebar active link style RE-ADDED */
        .sidebar-link.active {
            background: linear-gradient(90deg, #4f46e5, #8a46e5);
            color: #ffffff;
            font-weight: 600;
            box-shadow: inset 0 1px 2px rgba(0,0,0,0.2);
        }
        .sidebar-link.active:hover {
             transform: none;
             background: linear-gradient(90deg, #5a50f0, #9a50f0);
        }
        .sidebar-link.active svg {
            color: #ffffff;
        }

        /* Header Styles */
        .header-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: #e0e0ff;
        }
        .header-profile-button {
            display: flex;
            align-items: center;
            column-gap: 0.5rem;
            padding: 0.25rem;
            border-radius: 9999px;
            transition: background-color 0.15s ease-in-out;
        }
        .header-profile-button:hover {
             background-color: rgba(79, 70, 229, 0.2);
        }
        .header-profile-button:focus {
            outline: 2px solid transparent;
            outline-offset: 2px;
            box-shadow: 0 0 0 2px #1f1f38, 0 0 0 4px #6f6fff;
        }
        .header-profile-avatar {
            width: 2rem;
            height: 2rem;
            background: linear-gradient(135deg, #6f6fff, #c06fff);
            border-radius: 9999px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #ffffff;
            font-weight: 600;
            font-size: 0.875rem;
        }
        .header-profile-name {
            display: none;
            font-size: 0.875rem;
            font-weight: 500;
            color: #d0d0f0;
        }

        /* Main Content Sections */
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
            border-bottom: 1px solid #3a3a5a;
            padding-bottom: 0.75rem;
        }
        .section-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: #ffffff;
        }
        .section-content-container {
            background: linear-gradient(160deg, rgba(31, 31, 56, 0.9), rgba(26, 26, 46, 0.8));
            backdrop-filter: blur(4px);
            border-radius: 0.75rem;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.25);
            overflow: hidden;
            border: 1px solid #2a2a4a;
        }

        /* Buttons */
         .button {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            padding: 0.6rem 1.2rem;
            border-radius: 0.5rem;
            transition: background-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out, transform 0.1s ease-in-out;
            box-shadow: 0 2px 3px rgba(0, 0, 0, 0.15);
            font-size: 0.875rem;
            border: none;
            transform: translateY(0);
            text-decoration: none;
            cursor: pointer;
        }
        .button:hover {
             box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
             transform: translateY(-1px);
        }
        .button:active {
            transform: translateY(0px);
            box-shadow: inset 0 1px 2px rgba(0,0,0,0.2);
        }
        .button-primary {
            background: linear-gradient(90deg, #4f46e5, #8a46e5);
            color: #ffffff;
        }
        .button-primary:hover {
            background: linear-gradient(90deg, #5a50f0, #9a50f0);
        }
        .button-secondary {
            background-color: #3a3a5a;
            color: #e0e0ff;
            border: 1px solid #4a4a6a;
        }
        .button-secondary:hover {
            background-color: #4a4a6a;
        }
        .button-icon {
            width: 1rem;
            height: 1rem;
            margin-right: 0.375rem;
        }
        .button-icon-only {
             padding: 0.5rem;
        }
        .button-link-indigo {
            color: #9fa8ff;
            background: none;
            box-shadow: none;
            padding: 0.25rem;
            transition: color 0.15s ease-in-out, transform 0.1s ease-in-out;
            display: inline-block;
        }
        .button-link-indigo:hover {
            color: #c0c8ff;
            transform: scale(1.1);
        }
         .button-link-red {
            color: #ff8080;
            background: none;
            box-shadow: none;
            padding: 0.25rem;
            transition: color 0.15s ease-in-out, transform 0.1s ease-in-out;
            display: inline-block;
        }
        .button-link-red:hover {
            color: #ffa0a0;
            transform: scale(1.1);
        }
        .button-link-icon {
             width: 1.25rem;
             height: 1.25rem;
             display: inline-block;
             vertical-align: middle;
        }
        .action-button-group > a,
        .action-button-group > button {
             margin-right: 0.75rem;
        }
         .action-button-group > a:last-child,
         .action-button-group > button:last-child {
             margin-right: 0;
         }


        /* Tables */
        .table-container {
            overflow-x: auto;
        }
        .table {
            min-width: 100%;
        }
        .table thead {
            background: linear-gradient(90deg, #2a2a4a, #3a3a5a);
        }
        .table th {
            padding: 0.75rem 1.25rem;
            text-align: left;
            font-size: 0.75rem;
            font-weight: 600;
            color: #d0d0f0;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }
        .table tbody { }
        .table tbody tr {
             transition: background-color 0.15s ease-in-out;
             border-bottom: 1px solid #2a2a4a;
        }
         .table tbody tr:last-child {
             border-bottom: none;
         }
        .table tbody tr:hover {
            background-color: rgba(79, 70, 229, 0.1);
        }
        .table td {
            padding: 1rem 1.25rem;
            white-space: nowrap;
            font-size: 0.875rem;
            vertical-align: middle;
        }
        .table td.text-white { color: #ffffff; font-weight: 500; }
        .table td.text-gray-300 { color: #d0d0f0; }
        .table td.text-gray-400 { color: #b0b0d0; }

        /* Status Badges with Gradients */
        .status-badge {
            display: inline-flex;
            padding: 0.2rem 0.7rem;
            font-size: 0.75rem;
            line-height: 1.25rem;
            font-weight: 600;
            border-radius: 9999px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            text-shadow: 0 1px 1px rgba(0,0,0,0.2);
        }
        .status-badge-green {
            background: linear-gradient(45deg, #10b981, #34d399);
            color: #ffffff;
            border-color: #059669;
        }
        .status-badge-yellow {
            background: linear-gradient(45deg, #f59e0b, #fbbf24);
            color: #422006;
             border-color: #d97706;
             text-shadow: none;
        }
        .status-badge-blue {
            background: linear-gradient(45deg, #3b82f6, #60a5fa);
            color: #ffffff;
             border-color: #2563eb;
        }

        /* Pagination */
        .pagination-container {
            background-color: rgba(31, 31, 56, 0.7);
            padding: 0.75rem 1rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-top: 1px solid #2a2a4a;
        }
        .pagination-info {
            font-size: 0.875rem;
            color: #b0b0d0;
        }
        .pagination-info .font-medium { font-weight: 500; color: #ffffff; }

        .pagination-nav {
            position: relative;
            z-index: 0;
            display: inline-flex;
            border-radius: 0.375rem;
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
            margin-left: -1px;
        }
        .pagination-nav a, .pagination-nav span {
            position: relative;
            display: inline-flex;
            align-items: center;
            padding: 0.5rem 1rem;
            border: 1px solid #3a3a5a;
            background-color: #1f1f38;
            font-size: 0.875rem;
            font-weight: 500;
            color: #b0b0d0;
            transition: background-color 0.15s ease-in-out, border-color 0.15s ease-in-out, color 0.15s ease-in-out;
            margin-left: -1px;
        }
         .pagination-nav a:first-child {
             padding: 0.5rem;
             border-top-left-radius: 0.375rem;
             border-bottom-left-radius: 0.375rem;
         }
         .pagination-nav a:last-child {
             padding: 0.5rem;
             border-top-right-radius: 0.375rem;
             border-bottom-right-radius: 0.375rem;
         }
        .pagination-nav a:hover {
            background-color: #2a2a4a;
            border-color: #4a4a6a;
            color: #ffffff;
        }
        .pagination-nav a[aria-current="page"] {
            z-index: 10;
            background: linear-gradient(90deg, #4f46e5, #8a46e5);
            border-color: #4f46e5;
            color: #ffffff;
        }
         .pagination-nav span {
              color: #6b7280;
              padding: 0.5rem 1rem;
              background-color: #1f1f38;
              border-color: #3a3a5a;
         }
        .pagination-nav svg {
            height: 1.25rem;
            width: 1.25rem;
        }
        .sr-only {
            position: absolute;
            width: 1px;
            height: 1px;
            padding: 0;
            margin: -1px;
            overflow: hidden;
            clip: rect(0, 0, 0, 0);
            white-space: nowrap;
            border-width: 0;
        }

        /* Forms */
        .form-container {
             background: linear-gradient(160deg, rgba(31, 31, 56, 0.9), rgba(26, 26, 46, 0.8));
             backdrop-filter: blur(4px);
             border-radius: 0.75rem;
             box-shadow: 0 8px 16px rgba(0, 0, 0, 0.25);
             padding: 1.5rem;
             border: 1px solid #2a2a4a;
        }
        .form-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 1.5rem 1.25rem;
        }
        .form-label {
            display: block;
            font-size: 0.875rem;
            font-weight: 500;
            color: #d0d0f0;
            margin-bottom: 0.375rem;
        }
        .form-label-note {
            color: #7070a0;
            font-size: 0.75rem;
        }
        .form-input, .form-select, .form-textarea {
            width: 100%;
            background-color: rgba(31, 31, 56, 0.8);
            color: #ffffff;
            border: 1px solid #3a3a5a;
            border-radius: 0.5rem;
            padding: 0.6rem 0.8rem;
            transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
        }
        .form-input::placeholder, .form-textarea::placeholder {
            color: #7070a0;
        }
        .form-input:focus, .form-select:focus, .form-textarea:focus {
            box-shadow: 0 0 0 3px rgba(111, 111, 255, 0.4);
            border-color: #8f8fff !important;
            outline: none;
            background-color: rgba(31, 31, 56, 1);
        }
        .form-select {
             background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%239090c0' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='M6 8l4 4 4-4'/%3e%3c/svg%3e");
             background-position: right 0.5rem center;
             background-repeat: no-repeat;
             background-size: 1.5em 1.5em;
             padding-right: 2.5rem;
             -webkit-appearance: none;
             -moz-appearance: none;
             appearance: none;
        }
        .form-textarea {
            resize: vertical;
        }
        .form-actions {
            margin-top: 2rem;
            padding-top: 1.25rem;
            border-top: 1px solid #2a2a4a;
            display: flex;
            justify-content: flex-end;
            gap: 0.75rem;
        }

        /* Section Visibility using JS + active class */
        .admin-section {
            display: none; /* Hide all sections by default */
            opacity: 0;
            transition: opacity 0.3s ease-in-out;
            /* Removed scroll-margin-top as JS can handle scroll if needed */
        }
        .admin-section.active { /* Show active section */
            display: block;
            opacity: 1;
        }

        /* Responsive Styles */
        @media (min-width: 768px) { /* md breakpoint */
            .sidebar {
                display: flex;
            }
            .header-content {
                padding-left: 1.5rem;
                padding-right: 1.5rem;
            }
            .main-content {
                padding: 2rem;
            }
            .section-title {
                 font-size: 1.875rem;
            }
            .header-profile-name {
                display: inline;
            }
            .pagination-container .sm-hidden { display: none; }
            .pagination-container .sm-flex { display: flex; }
            .form-grid {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }
             .form-grid .md-col-span-2 {
                 grid-column: span 2 / span 2;
             }
             .pagination-nav .md-hidden { display: none; }
             .pagination-nav .md-inline-flex { display: inline-flex; }
        }

        @media (min-width: 1024px) { /* lg breakpoint */
             .header-content {
                padding-left: 2rem;
                padding-right: 2rem;
            }
             .main-content {
                padding: 2.5rem;
            }
             .form-container {
                 padding: 2rem;
             }
        }
         .pagination-container .sm-hidden { display: flex; }
         .pagination-container .sm-flex { display: none; }
         .pagination-nav .md-hidden { display: inline-flex; }
         .pagination-nav .md-inline-flex { display: none; }

         @media (min-width: 640px) { /* sm breakpoint */
             .pagination-container .sm-hidden { display: none; }
             .pagination-container .sm-flex { display: flex; flex: 1 1 0%; align-items: center; justify-content: space-between;}
         }
         @media (min-width: 768px) { /* md breakpoint */
             .pagination-nav .md-hidden { display: none; }
             .pagination-nav .md-inline-flex { display: inline-flex; }
         }

    </style>
</head>
<body class="antialiased">

    <div class="dashboard-layout">
        <aside class="sidebar">
            <div class="sidebar-header">
                <div class="sidebar-logo">
                    <span class="sidebar-logo-text">★</span>
                </div>
                <h1 class="sidebar-title">Admin Panel</h1>
            </div>

            <nav class="sidebar-nav">
                 <ul>
                     <li>
                         <a href="#" onclick="showSection('user-management', this)" class="sidebar-link active">
                             <svg class="" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M15.75 6a3.75 3.75 0 11-7.5 0 3.75 3.75 0 017.5 0zM4.501 20.118a7.5 7.5 0 0114.998 0A17.933 17.933 0 0112 21.75c-2.676 0-5.216-.584-7.499-1.632z" /></svg>
                             User Management
                         </a>
                     </li>
                     <li>
                         <a href="#" onclick="showSection('anime-management', this)" class="sidebar-link">
                             <svg class="" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M4.26 10.147a60.436 60.436 0 00-.491 6.347A48.627 48.627 0 0112 20.904a48.627 48.627 0 018.232-4.41 60.46 60.46 0 00-.491-6.347m-15.482 0a50.57 50.57 0 00-2.658-.813A59.905 59.905 0 0112 3.493a59.902 59.902 0 0110.399 5.84c-.896.248-1.783.52-2.658.814m-15.482 0A50.697 50.697 0 0112 13.489a50.702 50.702 0 017.74-3.342M6.75 15a.75.75 0 100-1.5.75.75 0 000 1.5zm0 0v-3.675A55.378 55.378 0 0112 8.443m-7.007 11.55A5.981 5.981 0 006.75 15.75v-1.5" /></svg>
                             Anime Management
                         </a>
                     </li>
                     <li>
                         <a href="#" onclick="showSection('add-anime', this)" class="sidebar-link">
                             <svg class="" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M12 9v6m3-3H9m12 0a9 9 0 11-18 0 9 9 0 0118 0z" /></svg>
                             Add New Anime
                         </a>
                     </li>
                 </ul>
            </nav>
        </aside>

        <div class="main-content-area">
            <header class="header">
                <div class="header-content">
                    <div>
                        <h1 class="header-title">Admin Dashboard</h1>
                    </div>
                    <div style="display: flex; align-items: center; column-gap: 1rem;"> <div style="position: relative;">
                            <button class="header-profile-button">
                                <span class="sr-only">Admin profile</span>
                                <div class="header-profile-avatar">A</div>
                                <span class="header-profile-name">Admin</span>
                            </button>
                            </div>
                    </div>
                </div>
            </header>

            <main class="main-content">

                <section id="user-management" class="admin-section active">
                    <div class="section-header">
                        <h2 class="section-title">User Management</h2>
                        <button onclick="alert('Add New User form/modal not implemented yet.');" class="button button-primary">
                            <svg class="button-icon" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15" /></svg>
                            Add New User
                        </button>
                    </div>

                    <div class="section-content-container">
                        <div class="table-container">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Username</th>
                                        <th>Email</th>
                                        <th>Joined</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td class="text-white">AnimeFan42</td>
                                        <td class="text-gray-300">fan42@example.com</td>
                                        <td class="text-gray-400">Jan 15, 2024</td>
                                        <td>
                                            <span class="status-badge status-badge-green">Active</span>
                                        </td>
                                        <td class="action-button-group">
                                            <button onclick="alert('Edit user: AnimeFan42')" class="button-link-indigo" title="Edit User">
                                                <svg class="button-link-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path></svg>
                                            </button>
                                            <button onclick="confirm('Are you sure you want to delete user: AnimeFan42?')" class="button-link-red" title="Delete User">
                                                <svg class="button-link-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path></svg>
                                            </button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="text-white">MangaReader99</td>
                                        <td class="text-gray-300">manga99@example.com</td>
                                        <td class="text-gray-400">Mar 22, 2024</td>
                                        <td>
                                            <span class="status-badge status-badge-green">Active</span>
                                        </td>
                                         <td class="action-button-group">
                                            <button onclick="alert('Edit user: MangaReader99')" class="button-link-indigo" title="Edit User">
                                                <svg class="button-link-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path></svg>
                                            </button>
                                            <button onclick="confirm('Are you sure you want to delete user: MangaReader99?')" class="button-link-red" title="Delete User">
                                                <svg class="button-link-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path></svg>
                                            </button>
                                        </td>
                                    </tr>
                                     <tr>
                                        <td class="text-white">OtakuMaster</td>
                                        <td class="text-gray-300">master@example.com</td>
                                        <td class="text-gray-400">Nov 5, 2023</td>
                                        <td>
                                            <span class="status-badge status-badge-yellow">Warned</span>
                                        </td>
                                         <td class="action-button-group">
                                            <button onclick="alert('Edit user: OtakuMaster')" class="button-link-indigo" title="Edit User">
                                                <svg class="button-link-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path></svg>
                                            </button>
                                            <button onclick="confirm('Are you sure you want to delete user: OtakuMaster?')" class="button-link-red" title="Delete User">
                                                <svg class="button-link-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path></svg>
                                            </button>
                                        </td>
                                    </tr>
                                    </tbody>
                            </table>
                        </div>
                        <div class="pagination-container">
                            <div class="sm-hidden"> <a href="#" class="button button-secondary"> Previous </a>
                                <a href="#" class="button button-secondary" style="margin-left: 0.75rem;"> Next </a>
                            </div>
                            <div class="sm-flex"> <div><p class="pagination-info">Showing <span class="font-medium">1</span> to <span class="font-medium">3</span> of <span class="font-medium">97</span> results</p></div>
                                <div><nav class="pagination-nav" aria-label="Pagination">
                                    <a href="#">
                                        <span class="sr-only">Previous</span>
                                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true"><path fill-rule="evenodd" d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z" clip-rule="evenodd" /></svg>
                                    </a>
                                    <a href="#" aria-current="page"> 1 </a>
                                    <a href="#"> 2 </a>
                                    <a href="#" class="md-inline-flex"> 3 </a>
                                    <span class="md-inline-flex"> ... </span>
                                    <a href="#" class="md-inline-flex"> 8 </a>
                                    <a href="#"> 9 </a>
                                    <a href="#"> 10 </a>
                                    <a href="#">
                                        <span class="sr-only">Next</span>
                                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true"><path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd" /></svg>
                                    </a>
                                </nav></div>
                            </div>
                        </div>
                    </div>
                </section>

                <section id="anime-management" class="admin-section">
                     <div class="section-header">
                        <h2 class="section-title">Anime Management</h2>
                        <button onclick="showSection('add-anime', this)" class="button button-primary">
                             <svg class="button-icon" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15" /></svg>
                            Add New Anime
                        </button>
                    </div>
                    <div class="section-content-container">
                        <div class="table-container">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Title</th>
                                        <th>Genre</th>
                                        <th>Episodes</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td class="text-gray-400">ANI001</td>
                                        <td class="text-white">Attack on Titan: Final Season</td>
                                        <td class="text-gray-300">Action, Drama, Fantasy</td>
                                        <td class="text-gray-400">28</td>
                                        <td>
                                            <span class="status-badge status-badge-blue">Airing</span>
                                        </td>
                                        <td class="action-button-group">
                                            <button onclick="alert('Edit anime: ANI001')" class="button-link-indigo" title="Edit Anime">
                                                <svg class="button-link-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path></svg>
                                            </button>
                                            <button onclick="confirm('Are you sure you want to delete anime: ANI001?')" class="button-link-red" title="Delete Anime">
                                                <svg class="button-link-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path></svg>
                                            </button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="text-gray-400">ANI002</td>
                                        <td class="text-white">Frieren: Beyond Journey's End</td>
                                        <td class="text-gray-300">Adventure, Drama, Fantasy</td>
                                        <td class="text-gray-400">28</td>
                                        <td>
                                            <span class="status-badge status-badge-green">Finished</span>
                                        </td>
                                        <td class="action-button-group">
                                            <button onclick="alert('Edit anime: ANI002')" class="button-link-indigo" title="Edit Anime">
                                                <svg class="button-link-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path></svg>
                                            </button>
                                            <button onclick="confirm('Are you sure you want to delete anime: ANI002?')" class="button-link-red" title="Delete Anime">
                                                <svg class="button-link-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path></svg>
                                            </button>
                                        </td>
                                    </tr>
                                    </tbody>
                            </table>
                        </div>
                         <div class="pagination-container">
                             <div class="sm-hidden"> <a href="#" class="button button-secondary"> Previous </a>
                                <a href="#" class="button button-secondary" style="margin-left: 0.75rem;"> Next </a>
                            </div>
                            <div class="sm-flex"> <div><p class="pagination-info">Showing <span class="font-medium">1</span> to <span class="font-medium">2</span> of <span class="font-medium">567</span> results</p></div>
                                <div><nav class="pagination-nav" aria-label="Pagination">
                                     <a href="#">
                                        <span class="sr-only">Previous</span>
                                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true"><path fill-rule="evenodd" d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z" clip-rule="evenodd" /></svg>
                                    </a>
                                    <a href="#" aria-current="page"> 1 </a>
                                    <a href="#"> 2 </a>
                                    <a href="#">
                                        <span class="sr-only">Next</span>
                                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true"><path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd" /></svg>
                                    </a>
                                </nav></div>
                            </div>
                        </div>
                    </div>
                </section>

                <section id="add-anime" class="admin-section">
                    <h2 class="section-title" style="margin-bottom: 1.5rem;">Add New Anime</h2>
                     <div class="form-container">
                         <form id="add-anime-form">
                             <div class="form-grid">
                                <div>
                                    <label for="anime-title-add" class="form-label">Anime Title</label>
                                    <input type="text" id="anime-title-add" name="anime-title" required class="form-input">
                                </div>
                                <div>
                                    <label for="anime-genre-add" class="form-label">Genre <span class="form-label-note">(comma-separated)</span></label>
                                    <input type="text" id="anime-genre-add" name="anime-genre" required class="form-input" placeholder="e.g., Action, Adventure">
                                </div>
                                 <div>
                                    <label for="anime-type-add" class="form-label">Type</label>
                                    <select id="anime-type-add" name="anime-type" class="form-select">
                                        <option>TV</option>
                                        <option>Movie</option>
                                        <option>OVA</option>
                                        <option>ONA</option>
                                        <option>Special</option>
                                        <option>Music</option>
                                    </select>
                                </div>
                                 <div>
                                    <label for="anime-episodes-add" class="form-label">Episodes</label>
                                    <input type="number" id="anime-episodes-add" name="anime-episodes" min="0" class="form-input" placeholder="Leave blank if unknown">
                                </div>
                                <div>
                                    <label for="anime-status-add" class="form-label">Status</label>
                                    <select id="anime-status-add" name="anime-status" class="form-select">
                                        <option>Finished Airing</option>
                                        <option>Currently Airing</option>
                                        <option>Not yet aired</option>
                                    </select>
                                </div>
                                 <div>
                                    <label for="image-url-add" class="form-label">Image URL</label>
                                    <input type="url" id="image-url-add" name="image-url" class="form-input" placeholder="https://example.com/image.jpg">
                                </div>
                                 <div class="md-col-span-2">
                                    <label for="anime-synopsis-add" class="form-label">Synopsis</label>
                                    <textarea id="anime-synopsis-add" name="anime-synopsis" rows="5" class="form-textarea"></textarea>
                                </div>
                            </div>
                            <div class="form-actions">
                                <button type="button" onclick="showSection('anime-management', this)" class="button button-secondary">
                                    Cancel
                                </button>
                                <button type="submit" class="button button-primary">
                                    Save Anime
                                </button>
                            </div>
                         </form>
                     </div>
                </section>

            </main>
        </div>
    </div>

    <script>
        /**
         * Shows the specified section and hides others.
         * Also updates the active state of the sidebar links.
         * @param {string} sectionId - The ID of the section to show.
         * @param {HTMLElement} [clickedLink=null] - The sidebar link element that was clicked.
         */
        function showSection(sectionId, clickedLink = null) {
            // Hide all sections first
            document.querySelectorAll('.admin-section').forEach(section => {
                section.classList.remove('active');
            });

            // Remove active class from all sidebar links
            document.querySelectorAll('.sidebar-link').forEach(link => {
                link.classList.remove('active');
            });

            // Show the target section
            const targetSection = document.getElementById(sectionId);
            if (targetSection) {
                // Use setTimeout to ensure display:block happens before transition starts
                 setTimeout(() => {
                    targetSection.classList.add('active');
                 }, 10); // Small delay helps ensure transition visibility
            }

            // Add active class to the clicked sidebar link (or find it if needed)
            let targetLink = clickedLink;
            if (!targetLink) {
                 // If called from a button (like Add New Anime), find the corresponding sidebar link
                 const links = document.querySelectorAll('.sidebar-link');
                 for (let link of links) {
                     const onclickAttr = link.getAttribute('onclick');
                     if (onclickAttr && onclickAttr.includes(`showSection('${sectionId}'`)) {
                         targetLink = link;
                         break;
                     }
                 }
            }
             if (targetLink) {
                 targetLink.classList.add('active');
             }

            // Prevent default anchor behavior if triggered by a link click
            if (clickedLink && clickedLink.tagName === 'A' && event) {
                event.preventDefault();
            }
        }

        /**
         * Handles the submission of the "Add New Anime" form.
         * Prevents default submission and logs data to console.
         * @param {Event} event - The form submission event.
         */
        function handleAddAnimeSubmit(event) {
            event.preventDefault(); // Prevent default form submission
            // --- Add your actual form submission logic here ---
            const formData = new FormData(event.target);
            const animeData = Object.fromEntries(formData.entries());
            console.log('Anime data to save:', animeData);
            alert('Anime "saved"! (Check console for data). Implement actual save logic.');
            // Optionally, clear the form or switch back to the anime list
            // event.target.reset();
            // showSection('anime-management'); // Need to find the link element here if switching view
        }

        // Add event listener for the form after the DOM is loaded
        document.addEventListener('DOMContentLoaded', () => {
            const addAnimeForm = document.getElementById('add-anime-form');
            if (addAnimeForm) {
                addAnimeForm.addEventListener('submit', handleAddAnimeSubmit);
            }

            // Ensure the default section's link is marked active on load
            // (The section itself already has the 'active' class in HTML)
            const initialActiveLink = document.querySelector('.sidebar-link.active');
            // No need to call showSection on load if default state is set in HTML
        });

    </script>

</body>
</html>
