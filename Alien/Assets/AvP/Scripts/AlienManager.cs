using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class AlienManager
{
    private static AlienManager instance;
    public Human[] players;
    public List<Alien> aliens;

    public static AlienManager Instance
    {
        get
        {
            if(instance == null)
            {
                instance = new AlienManager();
                instance.aliens = new List<Alien>();
            }

            return instance;
        }
    }

    public void AddAlien(Alien a)
    {
        aliens.Add(a);
    }

    public void RemoveAlien(Alien a)
    {
        aliens.Remove(a);
    }

    /*
    public void AStar()
    {
        float best = 1000;
        Human bestTarget = null;
        players = GameObject.FindObjectsOfType<Human>();



    }
*/



    
    public void GetTarget(Alien a)
    {
        float best = 1000;
        Human bestTarget = null;
        players = GameObject.FindObjectsOfType<Human>();


        for (int i = 0; i < players.Length; i++)
        {
            if (!players[i].attacked)
            {
                if(!players[i].carcass)
                {
                    float d = Vector3.Distance(a.transform.position, players[i].transform.position);
                    if (d < best)
                    {
                        best = d;
                        bestTarget = players[i];
                    }
                }
            }
        }

        a.target  = bestTarget;
    }
}