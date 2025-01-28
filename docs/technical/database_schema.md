User {
    user_id (PK)     : string
    email            : string
    password_hash    : string
    name             : string
    birth_date       : date
    height           : float
    weight          : float
    created_at      : date
    last_login      : date
    
}
Exercise {
    exercise_id (PK) : string
    name            : string
    category        : string
    description     : string
    equipment_needed: string
    difficulty      : string
    video_url       : string
    thumbnail_url   : string
}
ExerciseLevel {
    level_id (PK)    : string
    exercise_id (FK) : string
    level_number    : integer
    name            : string
    description     : string
    form_tips       : string
    min_reps        : integer
    max_reps        : integer
    recommended_sets: integer
    rest_time       : integer
    video_url       : string
}
ProgressionPath {
    progression_id (PK)      : string
    current_level_id (FK)    : string
    next_level_id (FK)      : string
    prerequisite_description : string
    minimum_sessions        : integer
    success_rate_required   : float
}
UserProgress {
    progress_id (PK) : string
    user_id (FK)     : string
    exercise_id (FK) : string
    level_id (FK)    : string
    current_reps     : integer
    current_sets     : integer
    current_weight   : float
    last_performed   : date
    notes            : string
}
UserWorkout {
    workout_id (PK)  : string
    user_id (FK)     : string
    name             : string
    created_at       : datetime
    is_template      : boolean
    notes            : string
}
WorkoutExercise {
    workout_exercise_id (PK) : string
    workout_id (FK)          : string
    exercise_id (FK)         : string
    level_id (FK)            : string
    order_in_workout         : integer
    target_sets             : integer
    target_reps             : integer
    rest_time               : integer
}
Subscription {
    subscription_id (PK) : string
    user_id (FK)         : string
    start_date           : date
    end_date             : date
    status               : string
    payment_method       : string
    amount               : float
}
