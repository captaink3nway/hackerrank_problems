package com.example.courtcounter;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {
    int score_a=0;
    int score_b=0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }
    /**
     * Displays the given score for Team A.
     */
    public void displayA(int score) {
        TextView scoreView = (TextView) findViewById(R.id.team_a_score);
        scoreView.setText(String.valueOf(score));
    }
    public void plusThreeA(View view){
        score_a=score_a+3;
        displayA(score_a);
    }
    public void plusTwoA(View view){
        score_a=score_a+2;
        displayA(score_a);
    }
    public void freeThrowA(View view){
        score_a=score_a+1;
        displayA(score_a);
    }
    public void displayB(int score) {
        TextView scoreView = (TextView) findViewById(R.id.team_b_score);
        scoreView.setText(String.valueOf(score));
    }
    public void plusThreeB(View view){
        score_b=score_b+3;
        displayB(score_b);
    }
    public void plusTwoB(View view){
        score_b=score_b+2;
        displayB(score_b);
    }
    public void freeThrowB(View view){
        score_b=score_b+1;
        displayB(score_b);
    }
    public void reset(View view){
        score_a=0;
        score_b=0;
        displayA(score_a);
        displayB(score_b);
    }
}
