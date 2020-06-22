import MySQLdb as mdb
#from liveMatchNew import Batsman, Bowler, Team

class databaseConnector(object):
    def __init__(self):
        try:
            self.db = mdb.connect(user='root',passwd='',db='cricketTournament',unix_socket='/opt/lampp/var/mysql/mysql.sock')
            self.cur = self.db.cursor()
        except mdb.Error as e:
            QMessageBox.about(self, 'Connection', 'Failed To Connect Database')
            sys.exit(1)
        print('Database Connected')

    def createTable(self):
        #with self.cur:
        self.cur.execute(f"CREATE TABLE tblTeams (teamname varchar(20), displayname varchar(5)) ") 
        self.db.commit()

    def insertTeam(self,teamName,displayTeamName):
        #with self.cur:
        self.cur.execute(f"INSERT INTO tblTeams (TeamName,DisplayName) VALUES ('{teamName}','{displayTeamName}')") 
        self.db.commit()

    def insertMatch(self,team1,team2,date,time,overs):
        #with self.cur:
        self.cur.execute(f"INSERT INTO tblMatches (Team1,Team2,Date,Time,Overs) VALUES('{team1}','{team2}','{date}','{time}',{overs})") 
        self.db.commit()

    def deleteTeam(self,displayTeamName):
        #with self.cur:
        self.cur.execute(f"DELETE FROM tblTeams WHERE DisplayName='{displayTeamName}'")
        self.db.commit()

    def getTeamsDispName(self):
        #with self.cur:
        self.cur.execute("SELECT DisplayName FROM tblTeams")
        data=self.cur.fetchall()
        teams=[_[0] for _ in data]
        return teams[:]

    def startLiveMatch(self, matchID):
        self.cur.execute(f"UPDATE tblMatches SET Status = 'OnGoing' WHERE MatchID = {matchID}")
        self.db.commit()

    def getMatch(self, matchID):
        self.cur.execute(f"SELECT MatchId,Team1,Team2,Overs from tblMatches WHERE MatchId= {matchID}")
        data=self.cur.fetchall()
        matchData = [x for x in data[0]]
        return matchData

    def getPointsTable(self):
        self.cur.execute(f"SELECT TeamName,Played,Won,Lost,NoResult,Points FROM tblTeams order by Points desc")
        data=self.cur.fetchall()
        pointsTable = list(data)
        return pointsTable

    def getTeams(self):
        #with self.cur:
        self.cur.execute("SELECT TeamName,DisplayName FROM tblTeams")
        data=self.cur.fetchall()
        teams=[[_[0],_[1]] for _ in data]
        return teams[:]

    def getCompletedMatches(self):
        #with self.cur:
            #self.cur.execute("SELECT Team1,Team2,Date,Time FROM tblMatches WHERE Status='UpComing'")
        self.cur.execute("SELECT MatchID,Team1,Team2,Winner FROM tblResults")
        data=self.cur.fetchall()
        #print(data)
        matches=[[_[0],_[1],_[2],_[3]] for _ in data]
        self.cur.execute("SELECT MatchID,Team1,Team2,Status FROM tblMatches WHERE Status='OnGoing'")
        data=self.cur.fetchall()
        #print(data)
        matches.extend([[_[0],_[1],_[2],_[3]] for _ in data])
        matches = sorted(matches)
        #print("asdf")
        #print(matches)
        return matches[:]

    def getUpcomingMatches(self):
        #with self.cur:
            #self.cur.execute("SELECT Team1,Team2,Date,Time FROM tblMatches WHERE Status='UpComing'")
        self.cur.execute("SELECT MatchID,Team1,Team2,Date,Time FROM tblMatches WHERE Status='UpComing'")
        data=self.cur.fetchall()
        matches=[[_[0],_[1],_[2],_[3],_[4]] for _ in data]
        return matches[:]

    def updateTeamName(self,teamName,displayName, prevName):
        #with self.cur:
        self.cur.execute(f"UPDATE tblTeams SET TeamName='{teamName}', DisplayName='{displayName}' WHERE DisplayName='{prevName}'") 
        self.db.commit()

    def updateCaptWK(self,capt,WK, teamName):
        #with self.cur:
        self.cur.execute(f"UPDATE tblTeams SET Captain='{capt} ',WicketKeeper='{WK}' WHERE DisplayName='{teamName}'") 
        self.db.commit()

    def getCaptWK(self,teamName):
        #with self.cur:
        self.cur.execute(f"SELECT Captain,WicketKeeper FROM tblTeams WHERE DisplayName='{teamName}'")
        data=self.cur.fetchall()
        captWK=[data[0][0],data[0][1]]
        return captWK[:]

    def getPlayers(self,teamName):
        #with self.cur:
        self.cur.execute(f"SELECT PlayerName FROM tblPlayer WHERE Team='{teamName}'")
        data=self.cur.fetchall()
        players=[_[0] for _ in data]
        return players[:]

    def getAllPlayers(self):
        #with self.cur:
        self.cur.execute(f"SELECT PlayerName FROM tblPlayer")
        data=self.cur.fetchall()
        players=[_[0] for _ in data]
        return players[:]

    def getPlayersTable(self,teamName):
        #with self.cur:
        self.cur.execute(f"SELECT PlayerName,BattingStyle,BowlingStyle,Matches FROM tblPlayer WHERE Team='{teamName}'")
        data=self.cur.fetchall()
        players=[[_[0],_[1],_[2],_[3]] for _ in data]
        return players[:]

    def insertPlayer(self,playerName,DOB,teamName,battingStyle,bowlingStyle):
        #with self.cur:
        #self.cur.execute(f"INSERT INTO tblTeams VALUES ('{teamName}','{displayTeamName}')")
        self.cur.execute(f"INSERT INTO tblPlayer(PlayerName,DOB,Team,BattingStyle,BowlingStyle) VALUES('{playerName}','{DOB}','{teamName}','{battingStyle}','{bowlingStyle}')")
        self.cur.execute(f"INSERT INTO tblBatting(BatsmanName) VALUES('{playerName}')")
        self.cur.execute(f"INSERT INTO tblBowling(BowlerName) VALUES('{playerName}')")
        self.db.commit()