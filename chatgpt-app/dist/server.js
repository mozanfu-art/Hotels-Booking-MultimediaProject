"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const cors_1 = __importDefault(require("cors"));
const app = (0, express_1.default)();
app.use((0, cors_1.default)());
app.use(express_1.default.json());
app.use(express_1.default.static('public'));
const API_KEY = process.env.ALPHA_VANTAGE_API_KEY || 'demo'; // Replace with your Alpha Vantage API key
app.post('/topMovers', async (req, res) => {
    const { limit = 10 } = req.body;
    // Mock data since Alpha Vantage demo may not work for this endpoint
    const mockGainers = [
        { ticker: 'AAPL', price: '150.00', change_amount: '+5.00', change_percentage: '+3.45%' },
        { ticker: 'GOOGL', price: '2800.00', change_amount: '+20.00', change_percentage: '+0.72%' },
        { ticker: 'MSFT', price: '300.00', change_amount: '+10.00', change_percentage: '+3.45%' },
        // Add more as needed
    ].slice(0, limit);
    const mockLosers = [
        { ticker: 'TSLA', price: '200.00', change_amount: '-10.00', change_percentage: '-4.76%' },
        { ticker: 'AMZN', price: '3000.00', change_amount: '-15.00', change_percentage: '-0.50%' },
        { ticker: 'NVDA', price: '400.00', change_amount: '-5.00', change_percentage: '-1.23%' },
        // Add more as needed
    ].slice(0, limit);
    res.json({ gainers: mockGainers, losers: mockLosers });
});
app.listen(3000, () => console.log('Server running on port 3000'));
