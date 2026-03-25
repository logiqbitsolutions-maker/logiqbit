import 'package:flutter/material.dart';
import 'models/project_model.dart';

class ProjectData {
  static final List<ProjectModel> apps = [
    ProjectModel(
      category: "MARKETING AUTOMATION",
      title: "ReplyRush",
      description:
          "Automate your Instagram DMs and never miss another sale, comment, or lead. ReplyRush is the #1 Instagram DM Automation Platform - built specifically for creators, influencers, and e-commerce brands.It's the ultimate ManyChat, Instachamp, and Chatfuel alternative designed to maximize engagement, boost replies, and grow your audience automatically.",
      tags: ["Automation", "Instagram", "DM Tool"],
      imageBgColor: const Color(0xFF6366F1),
      imageUrl: "assets/ReplyRush.jpeg",
      images: [
        "assets/ReplyRush_1.jpeg",
        "assets/ReplyRush_2.jpeg",
        "assets/ReplyRush_3.jpeg",
        "assets/ReplyRush_4.jpeg",
        "assets/ReplyRush_5.jpeg",
      ],
      icon: Icons.bolt_rounded,
    ),
    ProjectModel(
      category: "LEGAL COLLABORATION",
      title: "Expert Info",
      description:
          "ExpertInfo is a cutting-edge platform that revolutionizes the collaboration between legal professionals and expert witnesses. It connects law firms and attorneys with a vast network of specialized experts, ensuring every case receives the expert insight it deserves.",
      tags: ["LegalTech", "Expert Witness", "Law"],
      imageBgColor: const Color(0xFF2C3E50),
      imageUrl:
          "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource116/v4/fd/23/9b/fd239b13-61a6-0514-ca0a-374cc8c624a3/a0e0282f-e920-40c6-8eed-07a5708384fa_SS_1.png/300x650bb.webp",
      images: [
        "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource116/v4/fd/23/9b/fd239b13-61a6-0514-ca0a-374cc8c624a3/a0e0282f-e920-40c6-8eed-07a5708384fa_SS_1.png/300x650bb.webp",
        "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource126/v4/eb/12/2b/eb122b6d-e52f-754c-e074-daea087d61e8/f712a5fd-b556-46bc-a3fd-ce4008a71eb9_SS_2.png/300x650bb.webp",
        "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource116/v4/81/95/7c/81957ca9-b291-c3a0-88c5-312f9810e212/fee6fafa-dc73-46a8-ad68-7842583ca7f4_SS_3.png/300x650bb.webp",
        "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource126/v4/00/62/67/00626707-a6c7-8c88-4b2c-6c511263cba7/688a2978-d841-4c1c-9ca2-bcfc11ee8abb_SS_4.png/300x650bb.webp",
      ],
      icon: Icons.gavel_rounded,
    ),
    ProjectModel(
      category: "AI PHOTO STUDIO",
      title: "Dreamy AI",
      description:
          "Dreamy AI is the ultimate AI-powered photo studio that transforms your photos into stunning images. Create, edit, enhance, and explore trending photo styles with advanced tools like Background Remover, AI Smile, and AI Hug.",
      tags: ["AI Photo", "Editing", "Artistic"],
      imageBgColor: const Color(0xFF1A1A2E),
      imageUrl:
          "https://play-lh.googleusercontent.com/4U4LmZGQE58osh4tY0woy4n6A-1D_BXn63wOnQkCMxbQEC7dhV7AsfY5Y820PKBqiFhhVVz_4TYzPZRVpIyT-u4=w1052-h592-rw",
      images: [
        "https://play-lh.googleusercontent.com/4U4LmZGQE58osh4tY0woy4n6A-1D_BXn63wOnQkCMxbQEC7dhV7AsfY5Y820PKBqiFhhVVz_4TYzPZRVpIyT-u4=w1052-h592-rw",
        "https://play-lh.googleusercontent.com/uX4obAmJ4Lq4pgaDB_Hor1yWKyUcm5SRWxaLS7W7TiTNmlOD2ON4TuBweyQaZexmGj41pwM6VvmaB4Ur7H8s=w1052-h592-rw",
        "https://play-lh.googleusercontent.com/Co_n-RJqm8oGHuRPBF4uyQsBip3kHtzcTHSXsJO_IyRuywGFGMAuUf7xevp9LUllMBXfp_T7UoToIT2lcwssnQ=w1052-h592-rw",
      ],
      icon: Icons.auto_fix_high_rounded,
    ),
    ProjectModel(
      category: "SPORTS TRAINING",
      title: "Quickfeet Coach",
      description:
          "Quickfeet Coach is a revolutionary soccer training system. Connect the app with your Quickfeet Trainer rebounder to access 10 exciting drills that challenge players both mentally and physically through numbers, colors, and shapes.",
      tags: ["Soccer", "Training", "IoT"],
      imageBgColor: const Color(0xFF2E7D32),
      imageUrl:
          "https://play-lh.googleusercontent.com/uNaNZi4p6dF5-tWrtF-ZbUMcfki9G6PaWoUYwmhUpw32uoWYpH57OYDZwmXJwE5bKdc=w1052-h592-rw",
      images: [
        "https://play-lh.googleusercontent.com/uNaNZi4p6dF5-tWrtF-ZbUMcfki9G6PaWoUYwmhUpw32uoWYpH57OYDZwmXJwE5bKdc=w1052-h592-rw",
        "https://play-lh.googleusercontent.com/QaE8Yu9QOqeVwZxSIuW13hT_1DBHP6oW45xyt3fwP5zcrLcZIcpzcXhyEdfgTESfM1c=w1052-h592-rw",
        "https://play-lh.googleusercontent.com/yBlCNu0mYD5xtgVjvPvveESRI2VUcUlGp6VtxnxzJBuSn4HFCRABvHpGM3fucTBh21s=w1052-h592-rw",
      ],
      icon: Icons.sports_soccer_rounded,
    ),
  ];

  static final List<ProjectModel> games = [
    ProjectModel(
      category: "ACTION RPG",
      title: "Neon Genesis",
      description:
          "A fast-paced cyberpunk action RPG with deep narrative choices and next-gen graphics powered by Unreal Engine 5.",
      tags: ["RPG", "Cyberpunk", "Multiplayer"],
      imageBgColor: const Color(0xFF1E1E2C),
      imageUrl:
          "https://images.unsplash.com/photo-1542751371-adc38448a05e?auto=format&fit=crop&q=80&w=800",
      images: [
        "https://images.unsplash.com/photo-1542751371-adc38448a05e?auto=format&fit=crop&q=80&w=800",
        "https://images.unsplash.com/photo-1550745165-9bc0b252726f?auto=format&fit=crop&q=80&w=800",
      ],
      icon: Icons.gamepad,
    ),
    ProjectModel(
      category: "PUZZLE ADVENTURE",
      title: "Logic Realms",
      description:
          "Mind-bending puzzles set in a surreal dreamscape. Challenge your intellect with physics-based environmental riddles.",
      tags: ["Puzzle", "Indie", "Brain Teaser"],
      imageBgColor: const Color(0xFFE8D5CA),
      imageUrl:
          "https://images.unsplash.com/photo-1614294149010-950b698f72c0?auto=format&fit=crop&q=80&w=800",
      images: [
        "https://images.unsplash.com/photo-1614294149010-950b698f72c0?auto=format&fit=crop&q=80&w=800",
      ],
      icon: Icons.extension,
    ),
    ProjectModel(
      category: "STRATEGY SIM",
      title: "Urban Architect",
      description:
          "Build and manage a sustainable city of the future, balancing ecology, economy, and citizen happiness.",
      tags: ["Strategy", "Simulation", "City Builder"],
      imageBgColor: const Color(0xFF2D3436),
      imageUrl:
          "https://images.unsplash.com/photo-1518770660439-4636190af475?auto=format&fit=crop&q=80&w=800",
      images: [
        "https://images.unsplash.com/photo-1518770660439-4636190af475?auto=format&fit=crop&q=80&w=800",
      ],
      icon: Icons.location_city,
    ),
    ProjectModel(
      category: "SPACE EXPLORATION",
      title: "Star Voyager",
      description:
          "Embark on an epic journey across the galaxy, discovering new worlds and uncovering ancient alien secrets.",
      tags: ["Sci-Fi", "Exploration", "Open World"],
      imageBgColor: const Color(0xFF0F172A),
      imageUrl:
          "https://images.unsplash.com/photo-1614728263952-84ea206f99b6?auto=format&fit=crop&q=80&w=800",
      images: [
        "https://images.unsplash.com/photo-1614728263952-84ea206f99b6?auto=format&fit=crop&q=80&w=800",
      ],
      icon: Icons.rocket_launch,
    ),
  ];
}
