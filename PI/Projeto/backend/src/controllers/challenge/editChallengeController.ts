import { Request, Response } from "express";
import { EditChallengeService } from "../../services/challenge/editChallengeService";

export class EditChallengeController {
  async handle(req: Request, res: Response) {
    try {
      const data = req.body;
      const userId = req.userId;
      const service = new EditChallengeService();
      const response = await service.execute(data, userId);
      return res.json({ message: response, success: true });
    } catch (error) {
      return res.status(401).json({ message: error.message, success: false });
    }
  }
}
