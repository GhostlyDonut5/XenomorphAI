using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class FacehuggerManager
{

    private static FacehuggerManager instance;
    public Human[] players;
    public List<Facehugger> facehuggers;

    public static FacehuggerManager Instance
    {
        get
        {
            if (instance == null)
            {
                instance = new FacehuggerManager();
                instance.facehuggers = new List<Facehugger>();
            }

            return instance;
        }

    }

    public void AddFaceHugger(Facehugger f)
    {
        facehuggers.Add(f);
    }
    public void RemoveFaceHugger(Facehugger f)
    {
        facehuggers.Remove(f);
    }

    public void GetTarget(Facehugger f)
    {
        float best = 10000;
        Human bestTarget = null;
        players = GameObject.FindObjectsOfType<Human>();
        for (int i = 0; i < players.Length; i++)
        {
            if (!players[i].facehugged)
            {
                
                    float d = Vector3.Distance(f.transform.position, players[i].transform.position);
                    if (d < best)
                    {

                        best = d;
                        bestTarget = players[i];
                        players[i].targeted = true;
                    }
             
            }
        }

        f.target = bestTarget;
    }
}