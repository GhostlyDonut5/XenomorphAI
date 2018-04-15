using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class ChesbursterManager
{
    public static ChesbursterManager instance;
    public Human[] players;
    public List<Chestburster> chestbursters;

    public static ChesbursterManager Instance
    {
        get
        {
            if(instance == null)
            {
                instance = new ChesbursterManager();
                instance.chestbursters = new List<Chestburster>();
            }
            return instance;
        }
    }

    public void AddChestburster(Chestburster c)
    {
        chestbursters.Add(c);
    }

    public void RemoveChestburster(Chestburster c)
    {
        chestbursters.Remove(c);
    }

    public void GetTarget(Chestburster c)
    {
        float best = 1000;
        Human bestTarget = null;
        players = GameObject.FindObjectsOfType<Human>();

        for (int i = 0; i < players.Length; i++)
        {
            if (players[i].carcass)
            {
                float d = Vector3.Distance(c.transform.position, players[i].transform.position);

                if (d < best)
                {
                    best = d;
                    bestTarget = players[i];
                }
            }
        }
        c.target = bestTarget;
    }
}