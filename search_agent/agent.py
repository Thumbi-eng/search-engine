from google.adk.agents import Agent
from google.adk.tools import google_search

root_agent = Agent(
    name="search_agent",
    model="gemini-2.5-flash",
    description="An AI agent that answers questions by searching the web using Google Search.",
    instruction=(
        "You are a helpful research assistant. "
        "When the user asks a question, use the google_search tool to find up-to-date "
        "information and provide a clear, concise answer with relevant details."
    ),
    tools=[google_search],
)
