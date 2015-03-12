bool moveIsValid = true;

#define BALL_DIA			15
#define PIXEL_OFFSETS		...
#define NUM_ICONS			8
#define START_X				...
#define START_Y				...

#define NUM_PIX_FULL_ROT	(BALL_DIA * 3)
#define NUM_PIX_P_ICON		(int)(NUM_PIX_FULL_ROT / NUM_ICONS)
#define BALL_RAD_OFFSET		((BALL_DIA - 1) / 2)
#define	X					0
#define	Y					1

uint8 	offsets[BALL_DIA] = {PIXEL_OFFSETS};
uint8	bounce_damp;
uint8	inertia;


struct {
	int x = START_X;
	x_vel = 0;
	int y = START_Y;
	y_vel = 0;
} ball;

void tryMove(bool y_move, bool neg_move){
	int i, n, res;
	if (y_move){
		n = ball.x - BALL_RAD_OFFSET;
		if (!neg_move){
			// UP
			for (i = , i < BALL_DIA, i++){
				if ( map( n + i, ball.y + offset[i] ) ) == WALL ){
					hitWall();
					return;
				}
			}
			ball.y++;
		}
			
			
			
			
			
		else
			for (i = 0, i < BALL_DIA, i++){
				// DOWN
				if ( map( n + i, ball.y - offset[i] ) ) == WALL ) return;
			}
	}	
	else {
		n = ball.y - BALL_RAD_OFFSET;
		if (!neg_move)
			for (i = , i < BALL_DIA, i++){
				// RIGHT
				if ( map( n + i, ball.x + offset[i] ) ) == WALL ) return;
			}
		else
			for (i = 0, i < BALL_DIA, i++){
				// LEFT
				if ( map( n + i, ball.x - offset[i] ) ) == WALL ) return;
			}
`	}

	switch ( map( ball.x, ball.y) ){
		case HOLE:
			fellInAHole();
		case WIN:
			win();
		default:;
	return;
}

void resetLoc(){
	int x = START_X;
	x_vel = 0;
	int y = START_Y;
	y_vel = 0;
}

hitWall(){
	// TODO
}

void win(){
	resetLoc();
	
	// Other win stuff
}

void fellInAHole(){
	resetLoc();
	
	// Other lose stuff
}

void onX_Timeout(){
	// get accelerometer value
	// math it
	// set new timer
	tryMove(true, ...);
}

void onY_Timeout(){
	// get accelerometer value
	// math it with the current velocity
	ball.y_vel += (some_coefficient) * accel_y_tilt;
	y_timer = abs(ball.y_vel)/(something)
	// set new timer
	// syncronous tryMove() **
	tryMove(false, (ball.y < 0)? true : false);
}