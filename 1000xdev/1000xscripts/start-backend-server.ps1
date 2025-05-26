# PowerShell script to start the GigaSwap back-end FastAPI server
# Be in project root
# Change to the back-end directory (relative to project root)
cd back-end

# Activate the virtual environment
.gigaland\Scripts\activate

# Start the FastAPI server with uvicorn
.gigaland\Scripts\api.bat