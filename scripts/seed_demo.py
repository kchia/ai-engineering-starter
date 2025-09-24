#!/usr/bin/env python3
"""Seed demo data for Demo Day"""

import sys
import os

sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))


def seed_demo_data():
    """Create demo documents in Qdrant"""
    # client = get_qdrant_client()

    # Create collection
    print("🌱 Seeding demo data...")

    # Add sample documents
    # documents = [
    # "RAG stands for Retrieval-Augmented Generation.",
    # "LangGraph is a framework for building stateful agents.",
    # "RAGAS is an evaluation framework for RAG systems.",
    # ]

    # TODO: Add actual document processing
    print("✅ Demo data seeded!")


if __name__ == "__main__":
    seed_demo_data()
