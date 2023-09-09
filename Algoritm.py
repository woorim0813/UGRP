from surprise import Dataset, Reader, KNNBasic
import pandas as pd

# Sample data
user_food_ratings = {
    "user1": {"pizza": 5, "burger": 4, "salad": 2},
    "user2": {"pizza": 3, "burger": 5, "taco": 4},
    "user3": {"salad": 4, "taco": 3, "spaghetti": 5}
}

food_features = {
    "pizza": [1, 0, 0],   # meat
    "burger": [1, 0, 1],  # meat + spicy
    "salad": [0, 1, 0],   # vegan
    "taco": [1, 0, 1],    # meat + spicy
    "spaghetti": [1, 0, 0]  # meat
}

# Manual Clustering
def manual_clustering(features):
    cluster_map = {}
    for food, feature in features.items():
        primary_ingredient = feature.index(1) if 1 in feature else len(feature)
        if primary_ingredient not in cluster_map:
            cluster_map[primary_ingredient] = []
        cluster_map[primary_ingredient].append(food)
    return cluster_map

clustered_foods = manual_clustering(food_features)

# Collaborative Filtering
reader = Reader(rating_scale=(1, 5))
data = []

for user, ratings in user_food_ratings.items():
    for food, rating in ratings.items():
        data.append((user, food, rating))

dataset = Dataset.load_from_df(pd.DataFrame(data, columns=["user", "item", "rating"]), reader)
trainset = dataset.build_full_trainset()

algo = KNNBasic()
algo.fit(trainset)

# ... [The rest of the code remains unchanged]

# Recommendations for each user
for sample_user in user_food_ratings.keys():
    recs = []

    for cluster, foods in clustered_foods.items():
        for food in foods:
            if food not in user_food_ratings[sample_user]:
                estimated_score = algo.predict(sample_user, food).est
                recs.append((food, estimated_score))

    recommendations = sorted(recs, key=lambda x: x[1], reverse=True)
    print(f"Recommendations for {sample_user}: {recommendations}")
