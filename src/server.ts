import express from 'express';
import cors from 'cors';
import axios from 'axios';

const app = express();
app.use(cors());
app.use(express.json());
app.use(express.static('public'));

const API_KEY = process.env.ALPHA_VANTAGE_API_KEY || 'demo'; // Replace with your Alpha Vantage API key

app.post('/topMovers', async (req: any, res: any) => {
  const { limit = 10 } = req.body;

  const mockGainers = [
    { ticker: 'AAPL', price: '150.00', change_amount: '+5.00', change_percentage: '+3.45%' },
    { ticker: 'GOOGL', price: '2800.00', change_amount: '+20.00', change_percentage: '+0.72%' },
    { ticker: 'MSFT', price: '300.00', change_amount: '+10.00', change_percentage: '+3.45%' },
  ].slice(0, limit);

  const mockLosers = [
    { ticker: 'TSLA', price: '200.00', change_amount: '-10.00', change_percentage: '-4.76%' },
    { ticker: 'AMZN', price: '3000.00', change_amount: '-15.00', change_percentage: '-0.50%' },
    { ticker: 'NVDA', price: '400.00', change_amount: '-5.00', change_percentage: '-1.23%' },
  ].slice(0, limit);

  res.json({ gainers: mockGainers, losers: mockLosers });
});

// ✅ Health check route
app.get('/health', (req, res) => res.send('OK'));

// ✅ Dynamic port binding
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));